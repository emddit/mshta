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
echo exit >> %HOMEDRIVE%\part.scripthttps://github.com/emddit/mshta/edit/main/ipxe/install.bat
echo Running diskpart >> %HOMEDRIVE%\log.txt

title Formatting disks...
diskpart /s "%HOMEDRIVE%/part.script" >> %HOMEDRIVE%\log.txt

title Installing net driver...
echo Installing NetKVM Driver >> %HOMEDRIVE%\log.txt

cd \d %ProgramFiles%\CollabVM\driver\"
drvload "%ProgramFiles%\CollabVM\driver\netkvm.inf" >> %HOMEDRIVE%\log.txt
cd \d %WINDIR"\System32

title Running startnet...
echo Running startnet.exe >> %HOMEDRIVE%\log.txt
start "PENetwork" "%ProgramFiles%\PENetwork\PENetwork.exe"

title Wating for network...
ping 127.0.0.1 -n 5 > nul

title Downloading swim...
certutil.exe -urlcache -split -f "http://192.168.1.1/netboot/winpe_new/boot.wim" boot.wim >> %HOMEDRIVE%\log.txt

title Done!
echo Done >> %HOMEDRIVE%\log.txt
exit
