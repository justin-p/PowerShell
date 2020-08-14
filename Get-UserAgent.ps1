Function Get-UserAgent {
    # Based off https://gist.github.com/rossnz/5609904
    Param (
        [ValidateSet('Firefox', 'Chrome', 'InternetExplorer', 'Opera', 'Safari')]
        [string]$BrowserType
    )
    if (!$BrowserType) {
        $BrowserType = Get-Random -InputObject @('Firefox', 'Chrome', 'InternetExplorer', 'Opera', 'Safari')
    }
    Return [string]$([Microsoft.PowerShell.Commands.PSUserAgent]::$BrowserType)
}
