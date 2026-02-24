@echo off
echo Starting up > X:\log.txt
echo select disk 0 >> X:/part.script
echo clean >> X:/part.script
echo convert gpt >> X:/part.script
echo create partition efi size=500 >> X:/part.script
echo format fs=fat32 quick >> X:/part.script
echo assign letter J >> X:/part.script
echo create partition primary >> X:/part.script
echo format fs=ntfs quick >> X:/part.script
echo assign letter k >> X:/part.script
echo quit >> X:/part.script
echo Running diskpart >> X:\log.txt
diskpart /s "X:/part.script"
exit
