@ECHO off

REM Check/Get permission
:check_Permission
NET session >nul 2>&1
IF %errorLevel% == 0 (
    GOTO Activator
) ELSE (
    GOTO UACPrompt
)

:UACPrompt
ECHO Set UAC = CreateObject("Shell.Application") > "%temp%\getadmin1.vbs"
ECHO UAC.ShellExecute "cmd","/c ""%~s0"" %*", "", "runas", 1 >> "%temp%\getadmin1.vbs"
"%temp%\getadmin1.vbs"
DEL "%temp%\getadmin1.vbs"
EXIT

:Activator
SLMGR /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX >nul
SLMGR /skms kms.digiboy.ir >nul
SLMGR /ato >nul

REM Display activation status
echo Activation Status: 
cscript //nologo "%windir%\system32\slmgr.vbs" -xpr

REM Get system version
for /f "tokens=*" %%a in ('wmic os get caption ^| findstr /r /v "^$"') do set "version=%%a"

REM Display system version
echo System Version: %version%

REM Display activation details and redirect errors to error.txt
cscript //nologo "%windir%\system32\slmgr.vbs" /dli > error.txt 2>&1

EXIT
