function HaalDatDomainEvenOp {
        [CmdletBinding()]
        param(
            [Parameter(ValueFromPipeline=$True)]
            [String]
            $Domain
        )
    
        process {
            if($Domain) {
                $DomainContext = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext('Domain', $Domain)
                try {
                    [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain($DomainContext)
                }
                catch {
                    Write-Warning "The specified domain $Domain does not exist, could not be contacted, or there isn't an existing trust."
                    $Null
                }
            }
            else {
                [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
            }
        }
    }
    
    

function ZoekFFInDatDomeinDan {
    [CmdletBinding()]
    param(
        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [String]
        $ADSprefix,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )

    if(!$Domain) {
        $Domain = (HaalDatDomainEvenOp).name
    }
    else {
        if(!$DomainController) {
            try {
                $DomainController = ((HaalDatDomainEvenOp).PdcRoleOwner).Name
            }
            catch {
                throw "ZoekFFInDatDomeinDan: Error in retrieving PDC for current domain"
            }
        }
    }

    $SearchString = "LDAP://"

    if($DomainController) {
        $SearchString += $DomainController + "/"
    }
    if($ADSprefix) {
        $SearchString += $ADSprefix + ","
    }

    if($ADSpath) {
        if($ADSpath -like "GC://*") {
            $DistinguishedName = $AdsPath
            $SearchString = ""
        }
        else {
            if($ADSpath -like "LDAP://*") {
                $ADSpath = $ADSpath.Substring(7)
            }
            $DistinguishedName = $ADSpath
        }
    }
    else {
        $DistinguishedName = "DC=$($Domain.Replace('.', ',DC='))"
    }

    $SearchString += $DistinguishedName
    Write-Verbose "ZoekFFInDatDomeinDan search string: $SearchString"
    $Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)
    $Searcher.PageSize = $PageSize
    $Searcher
}


function WieWatHoeEnWaar {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$True)]
        [String]
        $UserName,

        [String]
        $Domain,

        [String]
        $DomainController,

        [String]
        $ADSpath,

        [String]
        $Filter,

        [Switch]
        $SPN,

        [Switch]
        $AdminCount,

        [Switch]
        $Unconstrained,

        [Switch]
        $AllowDelegation,

        [ValidateRange(1,10000)] 
        [Int]
        $PageSize = 200
    )

    begin {
        $UserSearcher = ZoekFFInDatDomeinDan -Domain $Domain -ADSpath $ADSpath -DomainController $DomainController -PageSize $PageSize
    }

    process {
        if($UserSearcher) {n
            if($Unconstrained) {
                Write-Verbose "Checking for unconstrained delegation"
                $Filter += "(userAccountControl:1.2.840.113556.1.4.803:=524288)"
            }
            if($AllowDelegation) {
                Write-Verbose "Checking for users who can be delegated"
                $Filter += "(!(userAccountControl:1.2.840.113556.1.4.803:=1048574))"
            }
            if($AdminCount) {
                Write-Verbose "Checking for adminCount=1"
                $Filter += "(admincount=1)"
            }
            if($UserName) {
                $UserSearcher.filter="(&(samAccountType=805306368)(samAccountName=$UserName)$Filter)"
            }
            elseif($SPN) {
                $UserSearcher.filter="(&(samAccountType=805306368)(servicePrincipalName=*)$Filter)"
            }
            else {
                $UserSearcher.filter="(&(samAccountType=805306368)$Filter)"
            }

            $UserSearcher.FindAll() | Where-Object {$_} | ForEach-Object {
                Convert-LDAPProperty -Properties $_.Properties
            }
        }
    }
}

function Convert-LDAPProperty {
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [ValidateNotNullOrEmpty()]
        $Properties
    )

    $ObjectProperties = @{}

    $Properties.PropertyNames | ForEach-Object {
        if (($_ -eq "objectsid") -or ($_ -eq "sidhistory")) {ing
            $ObjectProperties[$_] = (New-Object System.Security.Principal.SecurityIdentifier($Properties[$_][0],0)).Value
        }
        elseif($_ -eq "objectguid") {
            $ObjectProperties[$_] = (New-Object Guid (,$Properties[$_][0])).Guid
        }
        elseif( ($_ -eq "lastlogon") -or ($_ -eq "lastlogontimestamp") -or ($_ -eq "pwdlastset") -or ($_ -eq "lastlogoff") -or ($_ -eq "badPasswordTime") ) {
            if ($Properties[$_][0] -is [System.MarshalByRefObject]) {
                $Temp = $Properties[$_][0]
                [Int32]$High = $Temp.GetType().InvokeMember("HighPart", [System.Reflection.BindingFlags]::GetProperty, $null, $Temp, $null)
                [Int32]$Low  = $Temp.GetType().InvokeMember("LowPart",  [System.Reflection.BindingFlags]::GetProperty, $null, $Temp, $null)
                $ObjectProperties[$_] = ([datetime]::FromFileTime([Int64]("0x{0:x8}{1:x8}" -f $High, $Low)))
            }
            else {
                $ObjectProperties[$_] = ([datetime]::FromFileTime(($Properties[$_][0])))
            }
        }
        elseif($Properties[$_][0] -is [System.MarshalByRefObject]) {
            $Prop = $Properties[$_]
            try {
                $Temp = $Prop[$_][0]
                Write-Verbose $_
                [Int32]$High = $Temp.GetType().InvokeMember("HighPart", [System.Reflection.BindingFlags]::GetProperty, $null, $Temp, $null)
                [Int32]$Low  = $Temp.GetType().InvokeMember("LowPart",  [System.Reflection.BindingFlags]::GetProperty, $null, $Temp, $null)
                $ObjectProperties[$_] = [Int64]("0x{0:x8}{1:x8}" -f $High, $Low)
            }
            catch {
                $ObjectProperties[$_] = $Prop[$_]
            }
        }
        elseif($Properties[$_].count -eq 1) {
            $ObjectProperties[$_] = $Properties[$_][0]
        }
        else {
            $ObjectProperties[$_] = $Properties[$_]
        }
    }
    New-Object -TypeName PSObject -Property $ObjectProperties
}
