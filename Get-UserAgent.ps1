Function Get-UserAgent {
<#
    .NOTES
        Author: Justin Perdok (@JustinPerdok), https://justin-p.me.
        License: MIT
        Based off https://gist.github.com/rossnz/5609904

    .LINK
        https://github.com/justin-p/PowerShell/blob/master/Get-UserAgen.ps1
#>    
    Param (
        [ValidateSet('Firefox', 'Chrome', 'InternetExplorer', 'Opera', 'Safari')]
        [string]$BrowserType
    )
    if (!$BrowserType) {
        $BrowserType = Get-Random -InputObject @('Firefox', 'Chrome', 'InternetExplorer', 'Opera', 'Safari')
    }
    Return [string]$([Microsoft.PowerShell.Commands.PSUserAgent]::$BrowserType)
}
