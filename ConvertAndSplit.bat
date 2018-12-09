@echo off
REM | Thanks to DosItHelp from DosTips.com Forums for
REM | the script used to separate the folder and file paths!

REM | Separate folder and path variables
set BATFilePath=%0
set XCIFilePath=%1

REM Bat files can't handle most special characters in filenames or paths, so we adjust for this here
setlocal EnableDelayedExpansion
set BATFilePath=!BATFilePath:"=!
set XCIFilePath=!XCIFilePath:"=!

REM Separate folder and path variables
For %%A in ("!XCIFilePath!") do (
    set XCIFolder=%%~dpA
    set XCIFile=%%~nxA
)
For %%A in ("!BATFilePath!") do (
    set BATFolder=%%~dpA
)
rem debug checks
rem echo BAT path is: %BATFolder%
rem echo Full path is: %1
rem echo Folder is: %XCIFolder%
rem echo Filename is: %XCIFile%


REM Change to working directory
%BATFilePath:~0,2%

cd "%BATFolder:~2%"

REM Check for existing NSP files and for missing tools
if exist *.nsp echo Please remove all .nsp files from this directory before running this tool. & goto deset
if not exist 4nxci.exe set missingFile=4nxci.exe
if not exist keys.dat set missingFile=%missingFile% keys.dat
if not exist splitNSP.py set missingFile=%missingFile% splitXCI.py
if not "%missingFile%"=="" echo Required files missing: %missingFile% & goto deset

rem echo Copying !XCIFile!
rem echo to working directory
rem echo !BATFolder!temp\ ...
rem copy "!XCIFolder!!XCIFile!" "!BATFolder!temp\"
rem echo.
rem echo Done.
rem echo.

echo Converting XCI file to NSP file using keys.dat...
echo.

4nxci.exe "!XCIFolder!!XCIFile!"
echo.
echo Waiting for 4nxci.exe to finish. Press CTRL+C to abort if this hangs for a long time.
set startTime=%time:~6,2%
set waitTime=5

:waitfor4nxci
if %waitTime% GTR 0 (
if not %time:~6,2% EQU %startTime% (
set startTime=%time:~6,2%
set /a waitTime=%waitTime%-1
)
if not exist *.nsp goto waitfor4nxci
) else (
echo No .nsp file seems to have been generated. 4nxci.exe may have encountered an error.
goto deset
)

echo.
echo Done^^!
echo.
ren *.nsp "!XCIFile:~0,-4!.nsp"
echo Splitting XCI into 4GB parts...

python splitNSP.py -q "%XCIFile:~0,-4%.nsp"

echo Done^^!
echo.

echo * There will be a couple harmless errors here if the .nsp file is already smaller than 4GiB.
echo * This is normal. The .nsp file will still work fine.
echo.

echo Setting Archive attribute on files...
cd %XCIFile:~0,-4%_split.nsp
attrib +A *
cd ..
echo.
echo Setting Archive attribute on directory...
attrib +A "%XCIFile:~0,-4%_split.nsp"
echo.
echo Done^^!

echo.
:deset
REM | Unset variables
set startTime=
set waitTime=
set newNSPFile=
set missingFile=
set BATFilePath=
set BATFolder=
set XCIFolder=
set XCIFile=
set XCIFilePath=
pause