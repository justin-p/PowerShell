# portal credits
clear
function TypeTextObject {
    Param(
        [string]$Text,
        [switch]$newline,
        [int]$TimeInMSToTypeText=0,
        [int]$TimeInMSAfterText
    )
    If (![string]::IsNullOrEmpty($Text)) {
        $SleepBetweenChars = $($TimeInMSToTypeText / $Text.ToCharArray().count)
    }
    If ($TimeInMSToTypeText -eq 0){
        $SleepBetweenChars=80
    }
    return $(New-Object psobject -ArgumentList @{text=$text;newline=$newline;SleepBetweenChars=$SleepBetweenChars;TimeInMSAfterText=$TimeInMSAfterText})
}
function TypeText {
    Param(
        [string]$Text,
        [switch]$newline,
        [int]$SleepBetweenChars,
        [int]$TimeInMSAfterText
    )
    ForEach ($letter in $text.toCharArray()) {
        write-host $letter -NoNewline
        start-sleep -m $SleepBetweenChars
    }
    if ($newline) {write-host ""}
    if ($TimeInMSAfterText){start-sleep -m $TimeInMSAfterText}
}

$StillAlive=@()
$StillAlive+=TypeTextObject -Text "Forms FORM-29827281-12:" -newline
$StillAlive+=TypeTextObject -Text "Test Assessment Report" -newline
$StillAlive+=TypeTextObject -Text "" -newline 
$StillAlive+=TypeTextObject -Text "" -TimeInMSAfterText 1800
$StillAlive+=TypeTextObject -Text "This was a triumph" -newline -TimeInMSToTypeText 1500 -TimeInMSAfterText 1900
$StillAlive+=TypeTextObject -Text "I'm making a note here:" -newline -TimeInMSToTypeText 1800 -TimeInMSAfterText 200
$StillAlive+=TypeTextObject -Text "HUGE SUCCESS." -newline -TimeInMSToTypeText 1500 -TimeInMSAfterText 1300
$StillAlive+=TypeTextObject -Text "It's hard to " -TimeInMSToTypeText 1400
$StillAlive+=TypeTextObject -Text "overstate" -newline -TimeInMSToTypeText 1400
$StillAlive+=TypeTextObject -Text "my " -TimeInMSToTypeText 600
$StillAlive+=TypeTextObject -Text "satisfaction." -newline -TimeInMSToTypeText 1700 -TimeInMSAfterText 2200
$StillAlive+=TypeTextObject -Text "Aperture Science" -newline -TimeInMSToTypeText 1500 -TimeInMSAfterText 2200
$StillAlive+=TypeTextObject -Text "We do what we must" -newline -TimeInMSToTypeText 1600
$StillAlive+=TypeTextObject -Text "because " -TimeInMSToTypeText 600 -TimeInMSAfterText 100
$StillAlive+=TypeTextObject -Text "we " -TimeInMSToTypeText 400 -TimeInMSAfterText 100
$StillAlive+=TypeTextObject -Text "can." -newline -TimeInMSToTypeText 400 -TimeInMSAfterText 1800
$StillAlive+=TypeTextObject -Text "For the good of all of us." -newline -TimeInMSToTypeText 3000 -TimeInMSAfterText 200
$StillAlive+=TypeTextObject -Text "Except the ones who are dead." -newline -TimeInMSToTypeText 1700 -TimeInMSAfterText 300
$StillAlive+=TypeTextObject -Text "But there's no sense crying" -newline -TimeInMSToTypeText 1600
$StillAlive+=TypeTextObject -Text "over every mistake." -newline -TimeInMSToTypeText 1800 -TimeInMSAfterText 100
$StillAlive+=TypeTextObject -Text "You just keep on trying" -newline  -TimeInMSToTypeText 1800
$StillAlive+=TypeTextObject -Text "till you run out of cake." -newline -TimeInMSToTypeText 1800 -TimeInMSAfterText 300
$StillAlive+=TypeTextObject -Text "And the Science gets done." -newline -TimeInMSToTypeText 1600 -TimeInMSAfterText 100
$StillAlive+=TypeTextObject -Text "And you make a neat gun." -newline -TimeInMSToTypeText 1800 -TimeInMSAfterText 100
$StillAlive+=TypeTextObject -Text "For the people who are" -newline -TimeInMSToTypeText 1500 -TimeInMSAfterText 100
$StillAlive+=TypeTextObject -Text "still alive." -newline -TimeInMSToTypeText 1500 -TimeInMSAfterText 3000

## Prepare the screen
$host.UI.RawUI.BackgroundColor = "Black"
$host.UI.RawUI.ForegroundColor = "Yellow"
$Host.UI.RawUI.WindowTitle = "Still Alive"
Clear-Host

try {
    $host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size 83,45
}
catch {
    $host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size 83,45
}
try {
    $host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size 83,45
} catch {
    $host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size 83,45
}
try {
    $host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size 83,45
} catch {
    $host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size 83,45
}
try {
    $host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size 83,45
} catch {
    $host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size 83,45
}

## Open the background song
$script = @'
   $player = New-Object -ComObject 'MediaPlayer.MediaPlayer'
   $player.Open("https://github.com/justin-p/PowerShell/raw/master/StillAlive.wav")
   $player
'@

## ... in a background MTA-threaded PowerShell because
## the MediaPlayer COM object doesn't like STA

$runspace = [RunspaceFactory]::CreateRunspace()
$runspace.ApartmentState = "MTA"
$bgPowerShell = [PowerShell]::Create()
$bgPowerShell.Runspace = $runspace
$runspace.Open()
$player = @($bgPowerShell.AddScript($script).Invoke())[0]

Try
{
    ## Wait for it to buffer (or error out)
    while($true) {
        Start-Sleep -m 500
        if($player.HasError -or ($player.ReadyState -eq 4)) { break }
    }
    Start-Sleep -m 1600
    Clear-Host
    $host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates 0,0
    ForEach ($Entry in $StillAlive) {
        if ($entry.newline){
            TypeText -Text $Entry.text -SleepBetweenChars $Entry.SleepBetweenChars -newline
        } Else {
            TypeText -Text $Entry.text -SleepBetweenChars $Entry.SleepBetweenChars
        }
        if ($entry.TimeInMSAfterText) {
            start-sleep -Milliseconds $entry.TimeInMSAfterText
        }
    }
}
Finally
{
    ## Clean up, display exit screen
    Clear-Host
    $frames[-1] -split "`t"
    "`n"
    "                        Happy Scripting from PowerShell..."
    "                                 and Rick ASCII!"
    "`n`n`n"
    $player.Stop()
    $bgPowerShell.Dispose()
}
