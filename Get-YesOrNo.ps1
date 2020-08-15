Function Get-YesOrNo {
<#
    .NOTES
        Author: Justin Perdok (@JustinPerdok), https://justin-p.me.
        License: MIT

    .LINK
        https://github.com/justin-p/PowerShell/blob/master/Get-YesOrNo.ps1
#>    
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Title,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Question
    )
    Return $(Switch ($host.ui.PromptForChoice($Title, $Question, $('&yes','&no'), 0)) {
        0 { $true }
        1 { $false }
    })
}
