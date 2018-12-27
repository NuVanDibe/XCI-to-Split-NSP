# XCI-to-Split-NSP
tl;dr: Useful for those with FAT32 SD cards. Install XCI files larger than 4GB on Switch.

Download here if you have trouble navigating GitHub: https://github.com/NuVanDibe/XCI-to-Split-NSP/releases/

Sometimes software is only available in .xci format. Many people are saying to just copy that to a Micro SD card and use existing tools to convert it to NSP and install it on the fly. This is great and useful, but if the Micro SD card is formatted as FAT32, and the .xci file is larger than 4GiB, it becomes a much more complicated matter.

FAT32 has a maximum file size of 4GiB, so either only the first part of the file will be copied, or the operating system will complain about the file being too large for the destination file system.

The solution would be to first convert the file from XCI to NSP, and then split that NSP into 4GiB chunks which can fit on the Micro SD card. Then, set the Archive attribute on the folder and files so that NSP install tools can read the converted software and install it.

This script uses The-4n's 4NXCI (based on SciresM's hactool) and AnalogMan151's splitNSP to get the job done in one drag-and-drop operation.

# Instructions
One of the tools, splitNSP, requires Python3. Install Python3, if you haven't already.

Copy 4nxci.exe, splitNSP.py, and your **keys.dat** file *(you're on your own here)* into the same directory as the ConvertAndSplit.bat file.

Then, just drag your .xci file onto ConvertAndSplit.bat, and wait.

# Prerequisites
Don't forget, you need Python3, 4NXCI and splitNSP. Get them from their repositories here:

https://www.python.org/downloads/windows/

https://github.com/The-4n/4NXCI

https://github.com/AnalogMan151/splitNSP

# Installing Python

## If you haven't already installed Python, make sure you check the option to "Add Python 3.x to PATH" on the first screen of the installer.

Otherwise, you'll get an error stating:
`'python' is not recognized as an internal or external command, operable program or batch file.`
