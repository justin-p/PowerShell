Function Get-YesOrNo {
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
