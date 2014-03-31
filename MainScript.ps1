#This is the main script that starts for the Windows SteamBox
#Version 0.001

#Check to make sure Steam is installed
#Loop check
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
Start-Process -FilePath ${env:ProgramFiles(x86)}\Steam\Steam.exe


#Now that we have steam running, lets get to work on the background stuff
#Initiate Variables
$currentPath=Split-Path ((Get-Variable MyInvocation -Scope 0).Value).MyCommand.Path

#Wirte to file that steam ran and script worked
$Date =  Get-Date
$WriteToFile = "Ran correctly at: " + $Date
$WriteToFile | Out-File $currentPath\ran.txt
