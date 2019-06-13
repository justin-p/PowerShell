Function Edit-FirewallGPOTemplate
{
    <#
    .SYNOPSIS
        Function written to replace IPs in exporterd firewall GPO's. 
    .DESCRIPTION
        Function written to replace IPs in exporterd firewall GPO's. 
        It should work on any firewall GPO export, but in the examples we edited the GPO sand replaced the IPs with a string called 'ReplaceWithIP'.
        This ensures we don't match rules willy-nilly.
    .PARAMETER RegPol
        The location of the 'registry.pol' file that will be updated.
    .PARAMETER KeyPath
        The Registry key path it should scan. 
        For example: "SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules" in the case of firewall GPO's.
    .PARAMETER FindValue
        What value should it try to match to and replace with ReplaceValue
    .PARAMETER ReplaceValue
        The value replaces the matched value from FindValue.
    .PARAMETER WhatIf
        WhatIf
    .INPUTS
        None
    .OUTPUTS
        None
    .EXAMPLE
            Edit-FirewallGPOTemplate -RegPol "$GPOPath\$GPOID\DomainSysvol\GPO\Machine\registry.pol" -KeyPath "SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules" -FindValue "RA4=ReplaceWithIPs" -ReplaceValue "RA4=$IPs"
    .NOTES
        v1.00 5-12-2018
        Justin Perdok

        v1.01 19-12-2018
        'Properly' check input for ReplaceValue.
        Should really be done a more sophisticated way so you can't screwup a GPO and bork the firewall. -Justin Perdok
    #>
    #Requires -version 5
    #Requires -Modules PolicyFileEditor
    [CmdletBinding(SupportsShouldProcess=$true)]
    param
    (
        [Parameter(Mandatory=$true)]
        $RegPol,
        [Parameter()]
        $KeyPath = "SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules",
        [Parameter(Mandatory=$true)]
        $FindValue,
        [Parameter(Mandatory=$true)]
        $ReplaceValue
    )
    Begin {
        If (Select-String -Pattern "," -InputObject $ReplaceValue)
        {
            Write-Verbose 'Split Delimiter Found. Splitting each entry in `$ReplaceValue.'
            $SplitDelimiterfound = $true
        }
        ElseIf (Select-String -Pattern "-" -InputObject $ReplaceValue) {
            Write-Verbose 'Nonsplit Delimiter Found. Adding `$ReplaceValue as is.'
            $NonSplitDelimiterfound = $true
        }
        Else {
            Write-Verbose 'Found no Delimiter. Adding `$ReplaceValue as is.'
            $NoDelimiterFound = $true
        }
    }
    Process {
        If ($NonSplitDelimiterfound -or $NoDelimiterFound) {
            ForEach ($result in ((Get-PolicyFileEntry -Path $RegPol -All) | Where-Object {$_.Key -eq "$KeyPath"})) {
                Write-Debug ("Changing "+$result.ValueName)
                $FWRegDataSplit      = ($Result.Data) -Split "\|"
                $FWRegDataUpdatedIPs = $FWRegDataSplit -replace $FindValue,$ReplaceValue
                $FWRegDataMerged     = $FWRegDataUpdatedIPs -join "|"
                If ($pscmdlet.ShouldProcess("$($result.ValueName)", "Updating value in regpol file with $FWRegDataMerged")) {
                    Set-PolicyFileEntry -Path $RegPol -Key $result.Key -ValueName $result.ValueName -Data $FWRegDataMerged -NoGptIniUpdate
                }
            }
        }
        ElseIf ($SplitDelimiterfound) {
            ForEach ($result in ((Get-PolicyFileEntry -Path $RegPol -All) | Where-Object {$_.Key -eq "$KeyPath"})) {
                Write-Debug ("Changing "+$result.ValueName)
                $FWRegDataSplit      = ($Result.Data) -Split "\|"
                Write-Debug 'Ensureing $ReplaceValue is entered in a correct format'
                $ReplaceValueFixed = ForEach ($value in (($ReplaceValue -split ',') -replace 'RA4=','') -replace '\s','') {
                    ("RA4="+$value)
                } 
                $ReplaceValueFixedJoined = $ReplaceValueFixed -join '|'
                $FWRegDataUpdatedIPs     = $FWRegDataSplit -replace $FindValue,$ReplaceValueFixedJoined
                $FWRegDataMerged         = $FWRegDataUpdatedIPs -join "|"
                If ($pscmdlet.ShouldProcess("$($result.ValueName)", "Updating value in regpol file with $FWRegDataMerged")) {
                    Set-PolicyFileEntry -Path $RegPol -Key $result.Key -ValueName $result.ValueName -Data $FWRegDataMerged -NoGptIniUpdate
                }
            }            
        }
        Else {
            Write-Error -Message 'Not sure what todo here...'
        }
    }
    End {

    }
}
Import-Module -Name PolicyFileEditor
$Path                    = 'C:\_offline\temp\'
$RemotingIPs             = '192.168.2.1,192.168.2.2'
$GPOTemplateFolder       = "$Path\Templates\GPO\"
$GPOTempFolder           = ("$env:temp\" + (([System.Guid]::NewGuid() -split "-")[0]).ToString())
$cleanup                 = $true
New-Item  -Type Directory -Path $GPOTempFolder
Copy-Item -Path "$GPOTemplateFolder\" -Destination $GPOTempFolder -Recurse
$ComputerGPOs         = Get-ChildItem "$GPOTempFolder\GPO\Firewall\Computer Policys" -Directory | Sort-Object Name
ForEach ($GPO in $ComputerGPOs) {
	$GPOID = (Get-Childitem $($GPO.FullName) -Directory).Name     
	Write-Verbose "Replacing 'ReplaceWithIPs' with $($RemotingIPs) on $($GPO.Name)"
    Edit-FirewallGPOTemplate -RegPol "$($GPO.FullName)\$GPOID\DomainSysvol\GPO\Machine\registry.pol" -KeyPath "SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules" -FindValue "RA4=ReplaceWithIPs" -ReplaceValue "RA4=$RemotingIPs"   
}
# do something to import the GPO, etc ,etc
#
# cleanup
if($cleanup) {
    Remove-Item -Path $GPOTempFolder -Force -Recurse -Confirm:$false
}