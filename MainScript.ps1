#This is the main script that starts for the Windows SteamBox
#Version 0.001

#Check to make sure Steam is installed
#Loop check
$i = 0
do{
    [boolean]$SteamFileExists = test-path ${env:ProgramFiles(x86)}\Steam\Steam.exe
    if ($SteamFileExists -ne $True){
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

