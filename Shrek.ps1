function Get-ScriptDirectory
{
$Invocation = (Get-Variable MyInvocation -Scope 1).Value
Split-Path $Invocation.MyCommand.Path
}
$Path = Get-ScriptDirectory

function Shrek
{
$cursorTop = [Console]::CursorTop   
try 
{
    [Console]::CursorVisible = $false
    $shrek1 = @"
                 ,-'     `._                        
               ,'           `.        ,-.           
             ,'               \       ),.\          
   ,.       /                  \     /(  \;         
  /'\\     ,o.        ,ooooo.   \  ,'  `-')         
  )) )`. d8P"Y8.    ,8P"""""Y8.  `'  .--"'          
 (`-'   `Y'  `Y8    dP       `'     /               
  `----.(   __ `    ,' ,---.       (                
         ),--.`.   (  ;,---.        )               
        / \O_,' )   \  \O_,'        |               
       ;  `-- ,'       `---'        |               
       |    -'         `.           |               
      _;    ,            )          :               
   _.'|     `.:._   ,.::" `..       |               
--'   |   .'     """         `      |`.             
      |  :;      :   :     _.       |`.`.-'--.      
      |  ' .     :   :__.,'|/       |  \            
      `     \--.__.-'|_|_|-/        /   )           
       \     \_   `--^"__,'        ,    |           
       ;  `    `--^---'          ,'     |           
        \  `                    /      /            
         \   `    _ _          /                    
          \           `       /                     
           \           '    ,'                      
            `.       ,   _,'                        
              `-.___.---'                           
                                                    
┌─┐┬ ┬┬─┐┌─┐┬┌─  ┬┌─┐  ┬ ┬┌─┐┌┬┐┌─┐┬ ┬┬┌┐┌┌─┐  ┬ ┬┌─┐┬ ┬ 
└─┐├─┤├┬┘├┤ ├┴┐  │└─┐  │││├─┤ │ │  ├─┤│││││ ┬  └┬┘│ ││ │ 
└─┘┴ ┴┴└─└─┘┴ ┴  ┴└─┘  └┴┘┴ ┴ ┴ └─┘┴ ┴┴┘└┘└─┘   ┴ └─┘└─┘o


"@ 
    $shrek2 = @"
                 ,-'     `._                          
               ,'           `.        ,-.             
             ,'               \       ),.\            
   ,.       /                  \     /(  \;           
  /'\\     ,o.        ,ooooo.   \  ,'  `-')           
  )) )`. d8P"Y8.    ,8P"""""Y8.  `'  .--"'            
 (`-'   `Y'  `Y8    dP       `'     /                 
  `----.(   __ `    ,' ,---.       (                  
         ),--.`.   (  ;,---.        )                 
        / \ O ' )   \  \ O '        |                 
       ;  `-- ,'       `---'        |                 
       |    -'         `.           |                 
      _;    ,            )          :                 
   _.'|     `.:._   ,.::" `..       |                 
--'   |   .'     """         `      |`.               
      |  :;      :   :     _.       |`.`.-'--.        
      |  ' .     :   :__.,'|/       |  \              
      `     \--.__.-'|_|_|-/        /   )             
       \     \_   `--^"__,'        ,    |             
       ;  `    `--^---'          ,'     |             
        \  `                    /      /              
         \   `    _ _          /                      
          \           `       /                       
           \           '    ,'                        
            `.       ,   _,'                          
              `-.___.---'                             

┌─┐┬ ┬┬─┐┌─┐┬┌─  ┬┌─┐  ┬ ┬┌─┐┌┬┐┌─┐┬ ┬┬┌┐┌┌─┐  ┬ ┬┌─┐┬ ┬ 
└─┐├─┤├┬┘├┤ ├┴┐  │└─┐  │││├─┤ │ │  ├─┤│││││ ┬  └┬┘│ ││ │ 
└─┘┴ ┴┴└─└─┘┴ ┴  ┴└─┘  └┴┘┴ ┴ ┴ └─┘┴ ┴┴┘└┘└─┘   ┴ └─┘└─┘o

                                                            
"@                                                          
    $shrek3 = @"                                            
                 ,-'     `._                                
               ,'           `.        ,-.                   
             ,'               \       ),.\                  
   ,.       /                  \     /(  \;                 
  /'\\     ,o.        ,ooooo.   \  ,'  `-')                 
  )) )`. d8P"Y8.    ,8P"""""Y8.  `'  .--"'                  
 (`-'   `Y'  `Y8    dP       `'     /                       
  `----.(   __ `    ,' ,---.       (                        
         ),--.`.   (  ;,---.        )                       
        / \,_O' )   \  \,_O'        |                       
       ;  `-- ,'       `---'        |                       
       |    -'         `.           |                       
      _;    ,            )          :                       
   _.'|     `.:._   ,.::" `..       |                       
--'   |   .'     """         `      |`.                     
      |  :;      :   :     _.       |`.`.-'--.              
      |  ' .     :   :__.,'|/       |  \                    
      `     \--.__.-'|_|_|-/        /   )                   
       \     \_   `--^"__,'        ,    |                   
       ;  `    `--^---'          ,'     |                   
        \  `                    /      /                    
         \   `    _ _          /                            
          \           `       /                             
           \           '    ,'                              
            `.       ,   _,'                                
              `-.___.---'                                   

┌─┐┬ ┬┬─┐┌─┐┬┌─  ┬┌─┐  ┬ ┬┌─┐┌┬┐┌─┐┬ ┬┬┌┐┌┌─┐  ┬ ┬┌─┐┬ ┬ 
└─┐├─┤├┬┘├┤ ├┴┐  │└─┐  │││├─┤ │ │  ├─┤│││││ ┬  └┬┘│ ││ │ 
└─┘┴ ┴┴└─└─┘┴ ┴  ┴└─┘  └┴┘┴ ┴ ┴ └─┘┴ ┴┴┘└┘└─┘   ┴ └─┘└─┘o

                                                            
"@                                                          
    $StartShrek = start-job {
        Add-Type -AssemblyName presentationCore
        $filepath = [uri] "D:\Documents\git\PowerShell\5cHzAAnJbZIk.128.mp3"
        $wmplayer = New-Object System.Windows.Media.MediaPlayer
        $wmplayer.Open($filepath)
        Start-Sleep 2 # This allows the $wmplayer time to load the audio file
        $duration = $wmplayer.NaturalDuration.TimeSpan.TotalSeconds
        $wmplayer.Play()
        Start-Sleep $duration
        $wmplayer.Stop()
        $wmplayer.Close()
    }
    cls
    start-sleep -s 5
    while($StartShrek.JobStateInfo.State -eq "Running")
    {
        cls
        write-host = $shrek1 -ForegroundColor Green 
        Start-Sleep -Seconds 1
        cls
        write-host = $shrek2 -ForegroundColor Green   
        Start-Sleep -Seconds 1
        cls
        write-host = $shrek3 -ForegroundColor Green      
        Start-Sleep -Seconds 1
        cls
        write-host = $shrek2 -ForegroundColor Green   
        Start-Sleep -Seconds 1
    }
    # Only needed if you use a multiline frames
    Write-Host ($frames[0] -replace '[^\s+]', ' ')
}
finally 
{
    [Console]::SetCursorPosition(0, $cursorTop)
    [Console]::CursorVisible = $true
    shrek
}
}
Shrek