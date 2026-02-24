@echo off
title Preparing...

start /b taskmgr.exe

echo Starting up > %HOMEDRIVE%\log.txt
echo Installing curl >> "%HOMEDIRVE%\log.txt"
"%ProgramFiles%\7-Zip\7z.exe" e "%WINDIR\System32\curl-8.18.0_4-win64-mingw.zip" -Ocurl -y >> "%HOMEDIRVE%\log.txt"

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

title Downloading swim... Takes a while
echo Downloading swim >> %HOMEDRIVE%\log.txt

"%WINDIR\System32\curl\curl.exe" http://192.168.1.1/netboot/winpe_new/boot.wim -o boot.wim >> %HOMEDRIVE%\log.txt

title Applying image... takes a while
echo Applying image >> %HOMEDRIVE%\log.txt
dism /apply-image /imagefile:boot.wim /index:1 /applydir:K:\ >> %HOMEDRIVE%\log.txt

bcdboot K:\Windows /s J:\  >> %HOMEDRIVE%\log.txt >> %HOMEDRIVE%\log.txt

title Done!
echo Done >> %HOMEDRIVE%\log.txt

notepad %HOMEDRIVE%\log.txt
exit
