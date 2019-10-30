Function ConvertTo-ByteArray ($Value) {
    If ($Value.GetType().Name -ne 'Byte[]') {
        $Value = [System.Text.Encoding]::UTF8.GetBytes($Value)
    }
    Return $Value
}
Function ConvertFrom-ByteArray ([Byte[]]$Value) {
    If ($Value.GetType().Name -eq 'Byte[]') {
        $Value = [System.Text.Encoding]::Unicode.GetString($Value)
    }
    Return $Value
}
