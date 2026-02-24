@echo off
title Preparing...
start /b taskmgr.exe
echo Starting up > %HOMEDRIVE%\log.txt
echo select disk 0 >> %HOMEDRIVE%\part.script
echo clean >> %HOMEDRIVE%\part.script
echo convert gpt >> %HOMEDRIVE%\part.script
echo create partition efi size=500 >> %HOMEDRIVE%\part.script
echo format fs=fat32 quick >> %HOMEDRIVE%\part.script
echo assign letter J >> %HOMEDRIVE%\part.script
echo create partition primary >> %HOMEDRIVE%\part.script
echo format fs=ntfs quick >> %HOMEDRIVE%\part.script
echo assign letter K >> %HOMEDRIVE%\part.script
echo exit >> %HOMEDRIVE%\part.script
echo Running diskpart >> %HOMEDRIVE%\log.txt
title Formatting disks...
diskpart /s "%HOMEDRIVE%/part.script" %HOMEDRIVE%\log.txt
title Installing net driver...
echo Installing NetKVM Driver %HOMEDRIVE%\log.txt
"%ProgramFiles%\CollabVM\InstallDriver.bat"
title Running startnet...
echo Running startnet.exe >> %HOMEDRIVE%\log.txt
start "netstart" "%ProgramFiles%\PENetwork\PENetwork.bat"
title Done!
echo Done >> X:\Log.txt
exit
