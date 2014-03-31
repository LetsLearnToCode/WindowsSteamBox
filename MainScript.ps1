#This is the main script that starts for the Windows SteamBox
#Version 0.001

#Check to make sure Steam is installed
#Loop check


#*****************BEING FUNCTIONS*******************#

#Run Windows Updates function
Function Get-WindowsUpdate {
 
    [Cmdletbinding()]
    Param()
 
    Process {
        try {
            Write-Verbose "Getting Windows Update"
            $Session = New-Object -ComObject Microsoft.Update.Session            
            $Searcher = $Session.CreateUpdateSearcher()            
            $Criteria = "IsInstalled=0 and DeploymentAction='Installation' or IsPresent=1 and DeploymentAction='Uninstallation' or IsInstalled=1 and DeploymentAction='Installation' and RebootRequired=1 or IsInstalled=0 and DeploymentAction='Uninstallation' and RebootRequired=1"           
            $SearchResult = $Searcher.Search($Criteria)           
            $SearchResult.Updates | Out-File $currentPath\CurrentWindowsUpdates.txt
        } catch {
            Write-Warning -Message "Failed to query Windows Update because $($_.Exception.Message)" | Out-File $currentPath\ERROR.txt
        }
    }
}


#Start script

$i = 0
do{
    [boolean]$SteamFileExists = test-path ${env:ProgramFiles(x86)}\Steam\Steam.exe
    if ($SteamFileExists -eq $True){
            $i = 1
        }
        Else
        {
            $SteamErrorPopup = new-object -comobject wscript.shell
            $SteamErrorAnswer = $SteamErrorPopup.popup(“ERROR! STEAM NOT FOUND! “,0,”STEAM NOT FOUND!”,5)

            #Check answer
            switch ($SteamErrorAnswer)
            {
                1 {}
                2 {Exit}
                }

            }

} Until ($i -eq 1)

#Steam Exitsts! Lets start steam
Start-Process Powershell -ArgumentList "-file $currentPath\Managesteam.ps1"


#Now that we have steam running, lets get to work on the background stuff
#Initiate Variables
$currentPath=Split-Path ((Get-Variable MyInvocation -Scope 0).Value).MyCommand.Path

#Wirte to file that steam ran and script worked
$Date =  Get-Date
$WriteToFile = "Ran correctly at: " + $Date
$WriteToFile | Out-File $currentPath\ran.txt

#Run Windows Updates
Get-WindowsUpdate










