Function Format-StringToReverse {
	<#
	.SYNOPSIS
            Function that can reverses a string that has a delimiter.
	    
	.DESCRIPTION
            Function that can reverses a string that has a delimiter. 
            It splits the string with the supplied delimiter then uses [Array]::Reverse() to reverse the string.
            After reversing the string it joins it with the same delimiter used to split.
            This for example can be used to reverse the order of a users DN.
	    
        .NOTES
            Author: Justin Perdok (@JustinPerdok), https://justin-p.me.
            License: MIT
	    
	.LINK
	     https://github.com/justin-p/PowerShell/blob/master/Format-StringToReverse.ps1
	     
	.PARAMETER InputString
            A string you would like to reverse
	   
	.PARAMETER Delimiter
            The charachter between words in the string 
	   
        .EXAMPLE
            PS C:\> Format-StringToReverse -InputString 'This Is A String' -Delimiter ' '
            String A Is This               
	   
       .EXAMPLE
       	    PS C:\> $User = Get-ADUsers -Identity SomeUser
            PS C:\> $User.DistinguishedName
	       CN=SomeUser,OU=Users,OU=SomeOU,OU=CustomerName,DC=ad,DC=SomeDomain,DC=tld
	      
            PS C:\> $UserOUDN = $(Format-StringToReverse -InputString $($User.DistinguishedName) -SplitChar ',')
	    PS C:\> $UserOUDN
               DC=tld,DC=SomeDomain,DC=ad,OU=CustomerName,OU=SomeOU,OU=Users,CN=SomeUser
           
	    PS C:\> $($UserOUDN.SubString($UserOUDN.IndexOf('OU=')).split(',')[0]).replace('OU=','')
               CustomerName
	#>    
    [CmdletBinding(SupportsShouldProcess=$true)]
    Param (
        [String]$InputString,
        [String]$Delimiter
    )
    Begin {
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Debug "$($FunctionName) - Begin."
        Try {
            If ($script:ThisModuleLoaded -eq $true) {
                #Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
            }
            If ($PSCmdlet.ShouldProcess("$($FunctionName) - Creating '`$OutputObject'")) {
                Try {
                    [Array]$OutputObject = $($InputString.Split($Delimiter))
                }
                Catch {
                    Write-Error -Message "$($FunctionName) - $($PSItem)" -ErrorAction Stop
                }
            }
        }
        Catch {
            $PSCmdlet.ThrowTerminatingError($PSItem)
        }        
    } 
    Process {
        Write-Debug "$($FunctionName) - Process."
        Try {
            If ($PSCmdlet.ShouldProcess("$($FunctionName) - Filling '`$OutputObject'")) {
                Try {
                    [Array]::Reverse($OutputObject)
                    $OutputObject = $OutputObject -Join $($Delimiter)
                }
                Catch {
                    Write-Error -Message "$($FunctionName) - $($PSItem)" -ErrorAction Stop
                }
            }
        }
        Catch {
            $PSCmdlet.ThrowTerminatingError($PSItem)
        }
    }
    End {
        Try {
            If ($PSCmdlet.ShouldProcess("$($FunctionName) - Returning object")) {
                Try {
                    Return $OutputObject
                }
                Catch {
                    Write-Error -Message "$($FunctionName) - $($PSItem)" -ErrorAction Stop
                }
            }
        }
        Catch {
            $PSCmdlet.ThrowTerminatingError($PSItem)
        }
        Write-Debug "$($FunctionName) - End."
    }
}
