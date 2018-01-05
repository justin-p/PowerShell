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
$curdir = Get-ScriptDirectory
cp $curdir\command.ps1 "\\$env:ComputerName\Netlogon\"
ForEach ($computer in Get-ADComputer -Filter *)
{
	$ComputerName = $Computer.name
	Write-Host "Checking $ComputerName"
	cmd /c $scriptdir\PsExec.exe -nobanner -accepteula \\$ComputerName -s powershell -inputformat none -NoLogo -Noninteractive -NoProfile -executionPolicy bypass -file "\\$env:ComputerName\Netlogon\command.ps1"
}
rm "\\$env:ComputerName\Netlogon\command.ps1"