@echo off


:AdminReqScript

    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

:startup
color 0a
title "BOIII" loader by PowerTick
:title-screen
cls
echo  ________________________
echo !-----!BOIII LOADER!-----!
echo --------------------------

echo by PowerTick
echo Under the work of reactiongaming.us and Maurice Heumann
echo.
echo !!! MAKE SURE THAT SCRIPT IS EXTRACTED FROM THE ZIP!!!
echo This script only works with Windows 10 and 11
echo.
echo.
echo :Running checks...
if not exist ".\bin" (echo Install resources are not present, make sure that you have extracted the zip fully && echo Preventing loading, auto exiting && ping localhost -n 10 >nul && exit)
if not exist ".\bin\boiii.exe" (echo Client launcher is not present && echo Preventing loading, auto exiting && ping localhost -n 5 >nul && exit)
if not exist ".\bin\boiii.zip" (echo Client resources are not present && echo Preventing loading, auto exiting && ping localhost -n 5 >nul && exit)
echo ::Checks passed
echo.
:set-game-root
set /p gameroot= Game root directory?:
echo.
echo :Running gameroot check
if not exist "%gameroot%\BlackOps3.exe" (echo You're gameroot folder seems off, make sure that you have chosen the right directory path && goto set-game-root)
if not exist "%gameroot%\LPC\" (echo You're gameroot folder seems off, make sure that you have chosen the right directory path && goto set-game-root)
if not exist "%gameroot%\players\" (echo You're gameroot folder seems off, make sure that you have chosen the right directory path && goto set-game-root)
if not exist "%gameroot%\video\" (echo You're gameroot folder seems off, make sure that you have chosen the right directory path && goto set-game-root)
if not exist "%gameroot%\zone" (echo You're gameroot folder seems off, re-enter the game path directory path && goto set-game-root)
echo ::Gameroot check passed

echo :Copying launcher to game root
copy .\bin\boiii.exe "%gameroot%\"
echo ::Copied launcher to game

echo :Extracting client resources
echo Expand-Archive -Force "%cd%\bin\boiii.zip" "%HOMEDRIVE%%HOMEPATH%\AppData\Local\boiii\" >%temp%\extracttemp.ps1
powershell Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
powershell -file  %temp%\extracttemp.ps1
powershell Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser
del %temp%\extracttemp.ps1
echo ::Extracted 

echo :Loading ownership bypass patch!
set "cachePath=%localappdata%\cache\"
set "cacheFile=%cachePath%cache.bin"
set "cacheFile2=%cachePath%data.bin"
if not exist "%cachePath%" (
    mkdir "%cachePath%"
)
echo. > "%cacheFile%"
echo. > "%cacheFile2%"
echo ::Loaded bypass patch
echo.
echo Enjoy :)
echo.
pause >nul
exit





 
