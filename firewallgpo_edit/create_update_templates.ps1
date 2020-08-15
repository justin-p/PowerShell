<#
    .NOTES
        Author: Justin Perdok (@JustinPerdok), https://justin-p.me.
        License: MIT

    .LINK
        https://github.com/justin-p/PowerShell/blob/master/firewallgpo_edit/create_update_templates.ps1
#>

Import-Module -Name PolicyFileEditor
$GPOToUpdate = 'C:\_offline\temp\Example\registry.pol'
Get-PolicyFileEntry $GPOToUpdate -All
<#
ValueName                     Key                                                                                                                                                                                                                                                            Data
---------                     ---                                                                                                                                                                                                                                                            ----
DisableStatefulFTP            SOFTWARE\Policies\Microsoft\WindowsFirewall                                                                                                                                                                                                                       0
DisableStatefulPPTP           SOFTWARE\Policies\Microsoft\WindowsFirewall                                                                                                                                                                                                                       0
PolicyVersion                 SOFTWARE\Policies\Microsoft\WindowsFirewall                                                                                                                                                                                                                     538
                              SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\AuthorizedApplications
                              SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\GloballyOpenPorts
                              SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging
RemoteDesktop-In-TCP          SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules                         ...tive=TRUE|Dir=In|Protocol=6|LPort=3389|RA4=192.168.1.1|App=System|Name=@FirewallAPI.dll,-28753|Desc=@FirewallAPI.dll,-28756|EmbedCtxt=@FirewallAPI.dll,-28752|
RemoteDesktop-UserMode-In-TCP SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules                         ...192.168.1.1|App=%SystemRoot%\system32\svchost.exe|Svc=termservice|Name=@FirewallAPI.dll,-28853|Desc=@FirewallAPI.dll,-28856|EmbedCtxt=@FirewallAPI.dll,-28852|
                              SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\AuthorizedApplications
                              SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\GloballyOpenPorts
                              SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging
                              SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\AuthorizedApplications
                              SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\GloballyOpenPorts
                              SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging
#>

$RegPath = "SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules"
$RegName = 'RemoteDesktop-In-TCP'
$Rule = (Get-PolicyFileEntry -Path $GPOToUpdate -Key $RegPath -ValueName $RegName)
<#
PS C:\> $rule
ValueName            Key                                                       Data                                                                                                                                                                                                  Type
---------            ---                                                       ----                                                                                                                                                                                                  ----
RemoteDesktop-In-TCP SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules v2.26|Action=Allow|Active=TRUE|Dir=In|Protocol=6|LPort=3389|RA4=192.168.1.1|App=System|Name=@FirewallAPI.dll,-28753|Desc=@FirewallAPI.dll,-28756|EmbedCtxt=@FirewallAPI.dll,-28752| String
#>

$RuleSplit = ($Rule.data).Split('|')
<#
v2.26
Action=Allow
Active=TRUE
Dir=In
Protocol=6
LPort=3389
RA4=192.168.1.1
App=System
Name=@FirewallAPI.dll,-28753
Desc=@FirewallAPI.dll,-28756
EmbedCtxt=@FirewallAPI.dll,-2875
#>

$RuleSplit = $RuleSplit.replace('RA4=192.168.1.1', 'RA4=ReplaceWithIPs')
<#
v2.26
Action=Allow
Active=TRUE
Dir=In
Protocol=6
LPort=3389
RA4=ReplaceWithIPs
App=System
Name=@FirewallAPI.dll,-28753
Desc=@FirewallAPI.dll,-28756
EmbedCtxt=@FirewallAPI.dll,-28752
#>

$ruleJoined = $RuleSplit -join "|"
<#
v2.26|Action=Allow|Active=TRUE|Dir=In|Protocol=6|LPort=3389|RA4=ReplaceWithIPs|App=System|Name=@FirewallAPI.dll,-28753|Desc=@FirewallAPI.dll,-28756|EmbedCtxt=@FirewallAPI.dll,-28752|
#>

Set-PolicyFileEntry -Path $GPOToUpdate -Key $RegPath -ValueName $RegName -Data $ruleJoined -NoGptIniUpdate
<#
VERBOSE: Configuring 'SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules\RemoteDesktop-In-TCP' to value 'v2.26|Action=Allow|Active=TRUE|Dir=In|Protocol=6|LPort=3389|RA4=ReplaceWithIPs|App=System|Name=@FirewallAPI.dll,-28753|Desc=@FirewallAPI.dll,-28756|EmbedCtxt=@FirewallAPI.dll,-28752|' of type 'String'.#>
#>

Get-PolicyFileEntry -Path $GPOToUpdate -Key $RegPath -ValueName $RegName
<#
ValueName            Key                                                       Data                                                                                                                                                                                     Type
---------            ---                                                       ----                                                                                                                                                                                     ----
RemoteDesktop-In-TCP SOFTWARE\Policies\Microsoft\WindowsFirewall\FirewallRules v2.26|Action=Allow|Active=TRUE|Dir=In|Protocol=6|LPort=3389|RA4=ReplaceWithIPs|App=System|Name=@FirewallAPI.dll,-28753|Desc=@FirewallAPI.dll,-28756|EmbedCtxt=@FirewallAPI.dll,-28752| String
#>