# small mook-up script to sort your totally not pirated game collection by gerne.
# the gerne is currently checked using the igdb.com API.
# using this i was able to sort 250ish games, about 20 games where sorted incorrectly, probally duo name mismatch. 
# Todo/things to test
#      - make a list of prefered genres instead of just using the first gerne listed from igdb.com
#      - incorperate something like https://github.com/gravejester/Communary.PASM to check game names instead of just using the first result listed from igdb.com
#      - use SteamKit https://github.com/SteamRE/SteamKit instead of igdb

$baseurl = "API URL"
$apikey  = "API KEY"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.add("user-key", "$apikey")

# location of unsorted games
$unsortedlocation = "Z:\games\PC"

# location of sorted games
$sortedlocation   = "Z:\games\PC Sorted\"

# list of gernes used on igdb.com
$gernes = @('Point-and-click',
'Fighting',
'Shooter',
'Music',
'Platform',
'Puzzle',
'Racing',
'Real Time Strategy (RTS)',
'Role-playing (RPG)',
'Simulator',
'Sport',
'Strategy',
'Turn-based strategy (TBS)',
'Tactical',
'Hack and slashBeatem up',
'QuizTrivia',
'Pinball',
'Adventure',
'Indie',
'Arcade')

# create a folder for each gerne
ForEach ($gernetype in $gernes)
{
    mkdir -Path $sortedlocation\$gernetype
}

# get a list of local games.
# this script expects that the game is in a folder.
# I.E. 'Star.Wars.Battlefront.II.iso' is in a folder named 'Star Wars Battlefront II'
$listofgamestosort = Get-ChildItem -Directory -LiteralPath $Path | sort name

ForEach ($game in $listofgamestosort)
{
    # search igdb for a list of games like $gamename
    $gamename      = $game.Name
    $url           = $baseurl + "/games/?search=$gamename&fields=name,genres"   
    $request_game  = Invoke-RestMethod -Uri $url -Headers $headers

    # use the result from above and select the first game and its first gerne
    # check which gerne this is
    $gerne         = $request_game[0].genres[0]
    $url           = $baseurl + "/genres/$gerne"
    $request_gerne = Invoke-RestMethod -Uri $url -Headers $headers
    
    # remove any slashes and move the game to the gerne folder.
    $gamegerne     = $request_gerne.name
    $gamegerne     = $gamegerne -replace "\\",""
    Move-Item -LiteralPath "$path\$gamename" -Destination "$sortedlocation\$gamegerne\$gamename"
}
