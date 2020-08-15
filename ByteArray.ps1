Function ConvertTo-ByteArray ($Value) {
<#
    .NOTES
        Author: Justin Perdok (@JustinPerdok), https://justin-p.me.
        License: MIT

    .LINK
        https://github.com/justin-p/PowerShell/blob/master/ByteArray.ps1
#>
    If ($Value.GetType().Name -ne 'Byte[]') {
        $Value = [System.Text.Encoding]::UTF8.GetBytes($Value)
    }
    Return $Value
}
Function ConvertFrom-ByteArray ([Byte[]]$Value) {
<#
    .NOTES
        Author: Justin Perdok (@JustinPerdok), https://justin-p.me.
        License: MIT

    .LINK
        https://github.com/justin-p/PowerShell/blob/master/ByteArray.ps1
#>
    If ($Value.GetType().Name -eq 'Byte[]') {
        $Value = [System.Text.Encoding]::Unicode.GetString($Value)
    }
    Return $Value
}
