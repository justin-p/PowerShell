function Write-MyProgressBar {
    <#  
    .SYNOPSIS  
        Wrapper around Write-Progress.

    .DESCRIPTION
        Wrapper around Write-Progress. Makes your code look a lot cleaner when using Write-Progress.
      
    .NOTES  
        Author: Justin Perdok, https://justin-p.me.
        Based of: https://github.com/thomas-illiet/Write-MyProgress, Thomas ILLIET, https://thomas-illiet.fr
        License: MIT
        
    .PARAMETER ObjectToCalculate
        PowerShell Object used in the progress bar to calculate from.

    .PARAMETER Activity
        Specifies the first line of text in the heading above the status bar. This text describes the activity whose progress is being reported.

    .PARAMETER Task
        The name of the task that is running.

    .PARAMETER TaskPrefixText
        Any prefix text that should be added to the task.

    .PARAMETER StartTime
        The time used to calculate time elapsed and remaning. This should be set once outside of a ForEach.

    .PARAMETER Count
        Counter used to indicate the current entry from the ObjectToCalculate.

    .PARAMETER ManualTotalSteps
        Value that will be used to calculate against the $count for
        
    .PARAMETER id
        Specifies an ID that distinguishes each progress bar from the others. 
        Use this parameter when you are creating more than one progress bar in a single command. 
        If the progress bars do not have different IDs, they are superimposed instead of being displayed in a series.
      
    .PARAMETER ParentId
        Specifies the parent activity of the current activity. Use the value -1 if the current activity has no parent activity
      
    .PARAMETER NoTimeRemaining
        Can be used to skip the calculation of SecondsElapsed and SecondsRemaining

    .PARAMETER StepPercentage 
        Can be used to enable the Percentage based on the steps shown in the progress bar

    .PARAMETER NoPercentage
        Can be used to disable percentage based of the ObjectToCalculate

    .PARAMETER Completed
        Indicates whether the progress bar is visible. If this parameter is omitted, Write-MyProgressBar displays progress information.

    .PARAMETER NestedDepth
        Can be used to nest progress bars.  

    .PARAMETER AddPauses
        Adds pauses after writing the progress bar

    .PARAMETER ProgressBarWaitInMiliseconds
        How long a pause should take after writing a progress bar

    .PARAMETER NoCountIncrease
        Can be used to disable the count of the function. The functions updates the $Count param by one and returns it once its done.
        This simplyfies the the usage of the counter.
    
    .EXAMPLE  
        $GetProcess = Get-Process
        $Count = 0
        $StartTime = Get-Date
        ForEach($Process in $GetProcess) {
            $Count = Write-MyProgressBar -StartTime $StartTime -ObjectToCalculate $GetProcess -Count $Count -Activity "Showing info about Processess" -NestedDepth 1 -TaskPrefixText "Process" -Task "Process Path $($Process.path)" -AddPauses
        }
        Write-MyProgressBar -Activity "Showing info about Processess"  -NestedDepth 1 -Completed
    .EXAMPLE  
        $GetProcess = $(Get-Process)[0..4]
        $ProcessCount = 0
        $StartTime = Get-Date
        ForEach($Process in $GetProcess) {
            $ProcessCount = Write-MyProgressBar -StartTime $StartTime -ObjectToCalculate $GetProcess -Count $ProcessCount -Activity "Showing info about Processess" -TaskPrefixText "Process" -Task "Process Path $($Process.path)" -AddPauses -NoTimeRemaining -NoPercentage
            $ProcModuleCount = 0
            $SubStartTime = Get-Date
            ForEach ($ProcModule in $($process.modules)) {
                $ProcModuleCount = Write-MyProgressBar -StartTime $SubStartTime -ObjectToCalculate $($process.modules) -Count $ProcModuleCount -ID 2 -NestedDepth 1 -ParentID 1 -Activity "Showing info about Process modules" -TaskPrefixText "Module" -Task "Process module name $($ProcModule.ModuleName)" -AddPauses -NoPercentage
            }
            Write-MyProgressBar -Activity "Showing info about Processess modules" -ID 2 -NestedDepth 1 -ParentID 1 -Completed
            $ProcThreadCount = 0
            $SubStartTime = Get-Date
            ForEach ($ProcThread in $($process.threads)) {
                $ProcThreadCount = Write-MyProgressBar -StartTime $SubStartTime -ObjectToCalculate $($process.threads) -Count $ProcThreadCount -ID 2 -NestedDepth 1 -ParentID 1 -Activity "Showing info about Process threads" -TaskPrefixText "Thread" -Task "Process thread id $($ProcThread.id)" -AddPauses -ProgressBarWaitInMiliseconds 1000 -NoPercentage
            }
            Write-MyProgressBar -Activity "Showing info about Processess threads" -ID 2 -NestedDepth 1 -ParentID 1 -Completed
        }
        Write-MyProgressBar -Activity "Showing info about Processess" -NestedDepth 1 -Completed
    .EXAMPLE
        Function Get-Stuff {
            [cmdletbinding()]
            Param (
                [switch]$HardwareStuff,
                [switch]$MailStuff,
                [switch]$PowerShellStuff,
                [switch]$PythonStuff,
                [switch]$NetworkStuff
            )
            Begin {
                $StepCounter = 1
                $TotalSteps = 5
            } 
            Process {
                If ($HardwareStuff -eq $true) {
                    $StepCounter = Write-MyProgressBar -Activity "Getting information" -Task "Getting Hardware Info" -Count $StepCounter -NestedDepth 1 -ManualTotalSteps $TotalSteps -StepPercentage -AddPauses -ProgressBarWaitInMiliseconds 100 -NoTimeRemaining
                    $SomeFunction = "output"; start-sleep -s 1
                }
                If ($MailStuff -eq $true) {
                    $StepCounter = Write-MyProgressBar -Activity "Getting information" -Task "Getting Mail Info" -Count $StepCounter -NestedDepth 1 -ManualTotalSteps $TotalSteps -StepPercentage -AddPauses -ProgressBarWaitInMiliseconds 100 -NoTimeRemaining
                    $SomeFunction = "output"; start-sleep -s 1
                }
                If ($PowerShellStuff -eq $true) {
                    $StepCounter = Write-MyProgressBar -Activity "Getting information" -Task "Getting PowerShell Info" -Count $StepCounter -NestedDepth 1 -ManualTotalSteps $TotalSteps -StepPercentage -AddPauses -ProgressBarWaitInMiliseconds 100 -NoTimeRemaining
                    $SomeFunction = "output"; start-sleep -s 1
                }
                If ($PythonStuff -eq $true) {
                    $StepCounter = Write-MyProgressBar -Activity "Getting information" -Task "Getting Python Info" -Count $StepCounter -NestedDepth 1 -ManualTotalSteps $TotalSteps -StepPercentage -AddPauses -ProgressBarWaitInMiliseconds 100 -NoTimeRemaining
                    $SomeFunction = "output"; start-sleep -s 1
                }
                If ($NetworkStuff -eq $true) {
                    $StepCounter = Write-MyProgressBar -Activity "Getting information" -Task "Getting Network Info" -Count $StepCounter -NestedDepth 1 -ManualTotalSteps $TotalSteps -StepPercentage -AddPauses -ProgressBarWaitInMiliseconds 100 -NoTimeRemaining
                    $SomeFunction = "output"; start-sleep -s 1
                }                                      
            }
            End {
                Write-MyProgressBar -Activity "Getting information" -NestedDepth 1 -Completed -NoTimeRemaining
            }
        }
        Get-Stuff -HardwareStuff -MailStuff -PowerShellStuff -PythonStuff -NetworkStuff 
    #>
    Param(
          [parameter(Mandatory=$False)]
          [Array]$ObjectToCalculate,
          [parameter(Mandatory=$false)]
          [String]$Activity,
          [parameter(Mandatory=$false)]
          [String]$Task,
          [parameter(Mandatory=$false)]
          [String]$TaskPrefixText = 'Step',
          [parameter(Mandatory=$false)]
          [DateTime]$StartTime,
          [parameter(Mandatory=$false)]
          [Int]$Count,
          [parameter(Mandatory=$false)]
          [Int]$ManualTotalSteps,
          [parameter(Mandatory=$false)]
          [Int]$Id=1,
          [parameter(Mandatory=$false)]
          [Int]$ParentId=-1,
          [parameter(Mandatory=$false)]
          [Switch]$NoTimeRemaining,
          [parameter(Mandatory=$false)]
          [switch]$StepPercentage,
          [parameter(Mandatory=$false)]
          [Switch]$NoPercentage,
          [parameter(Mandatory=$false)]
          [Switch]$Completed = $false,
          [parameter(Mandatory=$false)]
          [Int]$NestedDepth = 0,
          [parameter(Mandatory=$false)]
          [Switch]$AddPauses,
          [parameter(Mandatory=$false)]
          [Int]$ProgressBarWaitInMiliseconds = 25,
          [parameter(Mandatory=$false)]
          [Switch]$NoCountIncrease
    )
    Begin {
        $Argument = @{}
        If ($null -ne $NestedDepth) {
            $Argument += @{ 
                ID = ($NestedDepth)
                ParentId = ($NestedDepth-1)
            } 
        } ElseIf (0 -eq $NestedDepth) {
            $Argument += @{ Id = $Id } 
        } Else {
            If($null -ne $id) { 
                $Argument += @{ Id = $Id } 
            }
            If($null -ne $ParentId) {
                $Argument += @{ ParentId = $ParentId } 
            }        
        }
        If ($null -eq $startTime -or $null -eq $ObjectToCalculate) {
            If ($StepPercentage -ne $true) {
                $NoTimeRemaining = $true
                $NoPercentage = $true
            } ElseIf ($StepPercentage -eq $true) {
                $NoTimeRemaining = $true            
            }
            If ([String]::IsNullOrEmpty(($Activity))) { 
                $Argument += @{
                  Activity =  "Processing Record $Count"
                } 
            }
        } ElseIf ($null -ne $ObjectToCalculate) {
            If ([String]::IsNullOrEmpty(($Activity))) { 
                $Argument += @{
                      Activity =  "Processing Record $Count of $($ObjectToCalculate.Count)"
                }
            }          
        } Elseif ($null -eq $Activity) {
            $Argument += @{
                  Activity = "Processing Record $Count"
            }             
        }
        If ($null -eq $Activity) {
            $Argument += @{
                  Activity = "Processing Record $Count"
            }
        } ElseIf ($null -eq $Argument.Activity) {
              $Argument += @{
                  Activity = $Activity
            }      
        }
        If ($NoPercentage -ne $True) {
            If ($StepPercentage -eq $true) {
                $Argument += @{
                    PercentComplete = (($Count/$($ManualTotalSteps)) * 100)
                    CurrentOperation = "$("{0:N2}" -f ((($Count/$($ManualTotalSteps)) * 100),2))% Complete"
                }
            } Else {      
                $Argument += @{
                    PercentComplete = (($Count/$($ObjectToCalculate.Count)) * 100)
                    CurrentOperation = "$("{0:N2}" -f ((($Count/$($ObjectToCalculate.Count)) * 100),2))% Complete"
                }   
            }      
        }
        If ($NoTimeRemaining -ne $true) {
            $SecondsElapsed = ((Get-Date) - $StartTime).TotalSeconds
            Try {
                [int]$SecondsRemaining = ($SecondsElapsed / ($Count / $ObjectToCalculate.Count)) - $SecondsElapsed
            } Catch {
                [int]$SecondsRemaining = 999
            }
            $Argument += @{ SecondsRemaining = $SecondsRemaining }
        }
        If ($Task) {
            If ($StepPercentage -eq $true) {
                $Argument += @{ status = $("$TaskPrefixText $Count out of $ManualTotalSteps | $Task") }
            } Else {
                $Argument += @{ status = $("$TaskPrefixText $Count out of $($ObjectToCalculate.Count) | $Task") }
            }
        }
        If ($Completed) {
            $Argument += @{ Completed = $Completed }        
        }
    }
    Process {    
        ForEach($Arg in $Argument.Keys) {
            Write-Debug $("Write-MyProgressBar - $Arg : $($Argument[$Arg])")
        }
    } 
    End {
        Write-Progress -ErrorAction SilentlyContinue @Argument
        If ($AddPauses) {
            Start-Sleep -Milliseconds $ProgressBarWaitInMiliseconds     
        }
        If ($Completed -eq $true) {
            Return
        }        
        If ($NoCountIncrease -ne $true) {
            Return $Count+1
        }
    }
}
