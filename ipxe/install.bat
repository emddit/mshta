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

cd \d %ProgramFiles%\CollabVM\driver\"
drvload "%ProgramFiles%\CollabVM\driver\netkvm.inf"
cd \d %WINDIR"\System32

title Running startnet...
echo Running startnet.exe >> %HOMEDRIVE%\log.txt

start "PENetwork" "%ProgramFiles%\PENetwork\PENetwork/exe"

title Done!
echo Done >> %HOMEDRIVE%\log.txt
exit
