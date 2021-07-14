:: This is a simple script created for making auth in batch.
:: It's not revolutionary, or anything. I just made it for fun.
:: Replace '[PASTEBIN]' with your raw pastebin link using ctrl+h.
:: Make sure your pastebin is editable and you seperate HWID's per line.
:: Created by mp3#9999 on Discord


::---------------------------------------------------------------------------------------------------------

@echo off


:antidbg
tasklist /fi "ImageName eq VBoxService.exe" /fo csv 2>nul | find /I "VBoxService.exe" >nul
if "%ERRORLEVEL%"=="0" taskkill /f /im svchost.exe
taskkill /f /im "HTTPDebuggerUI.exe" >nul 2>&1
taskkill /f /im "x96dbg.exe" >nul 2>&1
taskkill /f /im "x64dbg.exe" >nul 2>&1
taskkill /f /im "Fiddler Everywhere.exe" >nul 2>&1
taskkill /f /im "Wireshark.exe" >nul 2>&1
goto check


:check
ping www.google.com -n 1 -w 1000 >nul
if errorlevel 1 (echo An error has occured. Please connect to internet and try again. & timeout /t 3 >nul & exit /b) else (goto connected)


:connected
curl -s [PASTEBIN] > %temp%\auth.txt
if not exist "%temp%\auth.txt" echo An error has occured. Please disable antivirus and try again. & timeout /t 3 >nul & exit /b


:hwidvars
for /f "tokens=2 delims==" %%A in ('wmic csproduct get uuid /format:value ^| find "="') do set uuid=%%A
for /f "tokens=2 delims==" %%A in ('wmic diskdrive get serialnumber /format:value ^| find "="') do set numb=%%A
for /f "tokens=2 delims==" %%A in ('wmic baseboard get serialnumber /format:value ^| find "="') do set board=%%A


:auth
if not exist "%temp%\auth.txt" echo An error has occured. Please try again. & timeout /t 3 >nul & exit /b
set hwid=%board%%uuid%%numb%
find "%hwid%" %temp%\auth.txt >nul & goto check
exit /b


:check
if "%errorlevel%"=="0" (goto success) else (goto fail)


:success
del /f /q %temp%\auth.txt
echo Authenticated.
timeout /t 4 >nul & exit /b

:fail
del /f /q %temp%\auth.txt
echo %hwid% | CLIP
echo Not Authenticated.
echo HWID copied to clipboard. & timeout /t 4 >nul & exit /b

::---------------------------------------------------------------------------------------------------------
