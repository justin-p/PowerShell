#########################################################################################################
##                                                                                                      #
## Remote-SpeculationControlSettings                                                                    #
##                                                                                                      #
## This script runs the Get-SpeculationControlSettings remotely on all AD joined computers that are     #
## turned on using PSExec.                                                                              #
## This saves you from installing the module on all clients and servers.                                #
## Script expects to be run from a domain controller.                                                   #
## It will move a file containing Get-SpeculationControlSettings to the netlogon of the current DC      #
## Script expects that the current folder is writeable. Since it will create a log folder and a log file#
## per scanned PC.                                                                                      #
##                                                                                                      #
#########################################################################################################
##                                                                                                      #
## Version and change history:                                                                          #
## v1.00 05-01-2018                                                                                     #
## Initial version, Justin Perdok -Graficom Group                                                       #
##                                                                                                      #
#########################################################################################################
function Get-ScriptDirectory
{
	if ($hostinvocation -ne $null)
	{
		Split-Path $hostinvocation.MyCommand.path
	}
	else
	{
		Split-Path $script:MyInvocation.MyCommand.Path
	}
}
$date = Get-Date -Format yyyy_mm_dd_hh_mm_ss
$curdir = Get-ScriptDirectory
Copy-Item $curdir\command.ps1 "\\$env:ComputerName\Netlogon\"
mkdir     $curdir\logs
ForEach ($computer in Get-ADComputer -Filter *)
{
	$ComputerName = $Computer.name
	Start-Transcript -Path $curdir\logs\log_$ComputerName`_$date.txt
	Write-Host      "Checking $ComputerName"
	cmd /c $curdir\PsExec.exe -nobanner -accepteula \\$ComputerName -s powershell -inputformat none -NoLogo -Noninteractive -NoProfile -ExecutionPolicy Bypass -File "\\$env:ComputerName\Netlogon\command.ps1"
	Stop-Transcript
}
Remove-Item "\\$env:ComputerName\Netlogon\command.ps1"