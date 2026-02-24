@echo off
title Preparing...
echo Starting up > X:\log.txt
echo select disk 0 >> X:/part.script
echo clean >> X:/part.script
echo convert gpt >> X:/part.script
echo create partition efi size=500 >> X:/part.script
echo format fs=fat32 quick >> X:/part.script
echo assign letter J >> X:/part.script
echo create partition primary >> X:/part.script
echo format fs=ntfs quick >> X:/part.script
echo assign letter K >> X:/part.script
echo exit >> X:/part.script
echo Running diskpart >> X:\log.txt
title Formatting disks...
diskpart /s "X:/part.script" >> X:\log.txt
title Installing net driver...
"X:\Program Files\CollabVM\InstallDriver.bat" >> X:\Log.txt
title Running startnet...
start "X:\Program Files\PENetwork_x64\startnet.exe" >> X:\Log.txt
title Done!
echo Done >> X:\Log.txt
exit
