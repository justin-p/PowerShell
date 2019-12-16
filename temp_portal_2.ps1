# portal credits
# Play-Notes -Notes "R5E,R0Q.,A5E,E6Q,F#6E,G6Q.,E6E,C#6Q,D6Q.,E6Q,A5E,A5Q,F#6Q.,R0H"
# Play-Notes -Notes "R0H,G6E,F#6E,E6E,E6E,F#6H,R0H,R0Q,R0E,A5E,G6E,F#6E,E6E,E6Q,F#6E,D6Q.,E6E"
# Play-Notes -Notes "A5H,R5E,R0Q.,E6Q,F#6E,G6Q.,E6E,C#6Q.,D6E,E6Q,A5E,D6E,E6E"
# Play-Notes -Notes "F6E,E6E,D6E,C6E,R0Q,A5E,Bb5E,C6Q,F6Q,E6E,D6E,D6E,C6E,D6E,C6E,C6Q,C6Q,A5E,Bb5E"
# Play-Notes -Notes "C6Q,F6Q,G6E,F6E,E6E,D6E,D6E,E6E,F6Q,F6Q,G6E,A6E,Bb6E,Bb6E,A6Q,G6Q,F6E,G6E"
# Play-Notes -Notes "A6E,A6E,G6Q,F6Q,D6E,C6E,D6E,F6E,F6E,E6Q,E6E,F#6E,F#6Q."
# Play-Notes -Notes "A6E,A6E,G6Q,F6Q,D6E,C6E,D6E,F6E,F6E,E6Q,E6E,F#6E,F#6H"
# Play-Notes -Notes "G6E,A6E,A6Q,R0Q,R0E,G6E,F#6E,F#6Q"
# Play-Notes -Notes "G6E,A6E,A6Q,R0Q,R0E,G6E,F#6E,F#6Q"
# $arg = "-Notes 'R0H,G6E,F#6E,E6E,E6E,F#6H,R0H,R0Q,R0E,A5E,G6E,F#6E,E6E,E6E,F#6Q.,D6Q,E6E,A5H,R5E,R0Q.,A5E,E6Q,F#6E,G6Q.,E6E,C#6Q,D6Q.,E6Q,A5E,A5Q,F#6Q.,R0H,R0H,G6E,F#6E,E6E,E6E,F#6H,R0H,R0Q,R0E,A5E,G6E,F#6E,E6E,E6Q,F#6E,D6Q.,E6E,A5H,R5E,R0Q.,E6Q,F#6E,G6Q.,E6E,C#6Q.,D6E,E6Q,A5E,D6E,E6E,F6E,E6E,D6E,C6E,R0Q,A5E,Bb5E,C6Q,F6Q,E6E,D6E,D6E,C6E,D6E,C6E,C6Q,C6Q,A5E,Bb5E,C6Q,F6Q,G6E,F6E,E6E,D6E,D6E,E6E,F6Q,F6Q,G6E,A6E,Bb6E,Bb6E,A6Q,G6Q,F6E,G6E,A6E,A6E,G6Q,F6Q,D6E,C6E,D6E,F6E,F6E,E6Q,E6E,F#6E,F#6Q.,A6E,A6E,G6Q,F6Q,D6E,C6E,D6E,F6E,F6E,E6Q,E6E,F#6E,F#6H,G6E,A6E,A6Q,R0Q,R0E,G6E,F#6E,F#6Q,G6E,A6E,A6Q,R0Q,R0E,G6E,F#6E,F#6Q'"
$arg = "-Notes 'R0H,G6E,F#6E,E6E,E6E,F#6H,R0H,R0Q,R0E,A5E,G6E,F#6E,E6E,E6E,F#6Q.,D6Q,E6E,A5H,R5E,R0Q.,A5E,E6Q,F#6E,G6Q.,E6E,C#6Q,D6Q.,E6Q,A5E,A5Q,F#6Q.,R0H,R0H,G6E,F#6E,E6E,E6E,F#6H,R0H,R0Q,R0E,A5E,G6E,F#6E,E6E,E6Q,F#6E,D6Q.,E6E,A5H,R5E,R0Q.,E6Q,F#6E,G6Q.,E6E,C#6Q.,D6E,E6Q,A5E,D6E,E6E,F6E,E6E,D6E,C6E,R0Q,A5E,Bb5E,C6Q,F6Q,E6E,D6E,D6E,C6E,D6E,C6E,C6Q,C6Q,A5E,Bb5E,C6Q,F6Q,G6E,F6E,E6E,D6E,D6E,E6E,F6Q,F6Q,G6E,A6E,Bb6E,Bb6E,A6Q,G6Q,F6E,G6E'"
$command = {    Param (
        [Parameter(Mandatory = $true)]
        [string]$Notes,
        [Parameter(Mandatory = $false)]
        [int]$Tempo,
        [Parameter(Mandatory = $false)]
        [switch]$Output = $false
    )

    $NoteTypes = [pscustomobject]@{
        # W = Whole, H = Half, Q = Quarter, E = Eighth, S = Sixteenth
        'W'=1600;'W.'=2000;'H'=800;'H.'=1000;'Q'=400;'Q.'=600;'E'=200;'E.'=300;'S'=100;'S.'=150
    }
    $NoteIndex = [pscustomobject]@{
        'C'  = @(16.35,32.7,65.41,130.8,261.6,523.3,1047,2093,4186)
        'C#' = @(17.32,34.65,69.3,138.6,277.2,554.4,1109,2217,4435)
        'D'  = @(18.35,36.71,73.42,146.8,293.7,587.3,1175,2349,4699)
        'Eb' = @(19.45,38.89,77.78,155.6,311.1,622.3,1245,2489,4978)
        'E'  = @(20.6,41.2,82.41,164.8,329.6,659.3,1319,2637,5274)
        'F'  = @(21.83,43.65,87.31,174.6,349.2,698.5,1397,2794,5588)
        'F#' = @(23.12,46.25,92.5,185,370,740,1480,2960,5920)
        'G'  = @(24.5,49,98,196,392,784,1568,3136,6272)
        'G#' = @(25.96,51.91,103.8,207.7,415.3,830.6,1661,3322,6645)
        'A'  = @(27.5,55,110,220,440,880,1760,3520,7040)
        'Bb' = @(29.14,58.27,116.5,233.1,466.2,932.3,1865,3729,7459)
        'B'  = @(30.87,61.74,123.5,246.9,493.9,987.8,1976,3951,7902)
        'R'  = '0'
    }
    foreach ($Note in ($Notes -split ',')){
        $Note -match '(?<Pitch>[A-G][#|b]?|[R])(?<Octave>[0-8])?(?<NoteType>[Ww|Hh|Qq|Ee|Ss][\.]?)?' | Out-Null
        $Pitch = $matches['Pitch']
        if($matches['NoteType'] -eq $null){
            if($Tempo){
                [int]$Durration = 100/$Tempo*400
            }else{
                [int]$Durration = 400
            }
        }else{
            if($Tempo){
                [int]$Durration = 100/$Tempo*($NoteTypes.$($matches['NoteType']))
            }else{
                [int]$Durration = $NoteTypes.$($matches['NoteType'])
            }
        }
        [int]$Frequency = switch ($matches['Octave']) {
            0 {$NoteIndex.$Pitch} # Beep() does not support any frequencies lower than 38
            1 {$NoteIndex.$Pitch | Where-Object {$_ -ge 32 -and $_ -le 62}} # using <38 for Rests
            2 {$NoteIndex.$Pitch | Where-Object {$_ -ge 65 -and $_ -le 124}}
            3 {$NoteIndex.$Pitch | Where-Object {$_ -ge 130 -and $_ -le 247}}
            4 {$NoteIndex.$Pitch | Where-Object {$_ -ge 261 -and $_ -le 494}}
            5 {$NoteIndex.$Pitch | Where-Object {$_ -ge 523 -and $_ -le 988}}
            6 {$NoteIndex.$Pitch | Where-Object {$_ -ge 1047 -and $_ -le 1978}}
            7 {$NoteIndex.$Pitch | Where-Object {$_ -ge 2093 -and $_ -le 3952}}
            8 {$NoteIndex.$Pitch | Where-Object {$_ -ge 4186 -and $_ -le 7902}}
            default {$NoteIndex.$Pitch | Where-Object {$_ -ge 523 -and $_ -le 988}}
        }
        if($Output){
            ($Pitch+$matches['Octave']+$matches['NoteType']+' - '+"${Durration}"+' - '+"${Frequency}")
        }
        if($Pitch -eq 'R'){
            Start-Sleep -Milliseconds $Durration
        }
        else{
            [console]::beep($Frequency,$Durration)
        }
        $Note = $null
        $Pitch = $null
        $Durration = $null
        $Frequency = $null
    }
    $Tempo = $null}
function TypeTextObject {
    Param(
        [string]$Text,
        [switch]$newline,
        [int]$sleep = 80,
        [int]$endsleep
    )
    return $(New-Object psobject -ArgumentList @{text=$text;newline=$newline;sleep=$sleep;endsleep=$endsleep})
}
function TypeText {
    Param(
        [string]$Text,
        [switch]$newline,
        [int]$sleep,
        [int]$endsleep
    )
    ForEach ($letter in $text.toCharArray()) {
        write-host $letter -NoNewline
        start-sleep -m $sleep
    }
    if ($newline) {write-host ""}
    if ($endsleep){start-sleep -m $endsleep}
}

$Object1=@()
$Object1+=TypeTextObject -Text "Forms FORM-29827281-12:" -newline -sleep 80
$Object1+=TypeTextObject -Text "Test Assessment Report" -newline -sleep 80
$Object1+=TypeTextObject -Text "" -newline
$Object1+=TypeTextObject -Text "" -newline
$Object2=@()
$Object2+=TypeTextObject  -Text "" -endsleep 1500
$Object2+=TypeTextObject  -Text "This was a triumph" -newline -sleep 50 -endsleep 2000
$Object2+=TypeTextObject -Text "I'm making a note here:"  -newline -sleep 50 -endsleep 250
$Object2+=TypeTextObject -Text "HUGE SUCCESS." -newline -sleep 50 -endsleep 1000
$Object2+=TypeTextObject -Text "It's hard to " -sleep 80
$Object2+=TypeTextObject -Text "overstate" -newline -sleep 150
$Object2+=TypeTextObject -Text "my " -sleep 80
$Object2+=TypeTextObject -Text "satisfaction." -newline -sleep 100 -endsleep 1800
$Object2+=TypeTextObject -Text "Aperture Science" -newline -sleep 80 -endsleep 1100
$Object2+=TypeTextObject -Text "We do what we must" -newline -sleep 70
$Object2+=TypeTextObject -Text "because we can." -newline -sleep 80 -endsleep 1400
$Object2+=TypeTextObject -Text "For the good of all of us." -newline -sleep 80
$Object2+=TypeTextObject -Text "Except the ones who are dead." -newline -sleep 45 -endsleep 500

ForEach ($Entry in $object1) {
    if ($entry.newline){
        TypeText -Text $Entry.text -sleep $Entry.sleep -newline
    } Else {
        TypeText -Text $Entry.text -sleep $Entry.sleep
    }
}
Start-Process powershell -ArgumentList "-noexit -noprofile -windowstyle hidden -command & {$command}  $arg"

ForEach ($Entry in $Object2) {
    if ($entry.newline){
        TypeText -Text $Entry.text -sleep $Entry.sleep -newline
    } Else {
        TypeText -Text $Entry.text -sleep $Entry.sleep
    }
    if ($entry.endsleep) {
        start-sleep -Milliseconds $entry.endsleep
    }
}

# TypeText -Text "But there's no sense crying" -newline -sleep 110
# TypeText -Text "over every mistake." -newline -sleep 110
# TypeText -Text "You just keep on trying" -newline -sleep 110
# TypeText -Text "till you run out of cake." -newline -sleep 110
# TypeText -Text "And the Science gets done." -newline -sleep 110
# TypeText -Text "And you make a neat gun." -newline -sleep 110
# TypeText -Text "For the people who are" -newline -sleep 110
# TypeText -Text "still alive." -newline -sleep 110
# start-sleep -Milliseconds 1500
# TypeText -Text ""
#
