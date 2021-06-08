:: This is a simple script created for making auth in batch.
:: It's not revolutionary, or anything. I just made it for fun.
:: Replace '[PASTEBIN]' with your raw pastebin link using ctrl+h.
:: Make sure your pastebin is editable and you seperate HWID's per line.
:: Created by mp3#9999 on Discord


::---------------------------------------------------------------------------------------------------------

@echo off


ping www.google.com -n 1 -w 1000 >nul
if errorlevel 1 (echo An error has occured. Please connect to internet and try again. & timeout /t 3 >nul & exit /b) else (goto connected)


:connected
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
powershell -Command "$progressPreference = 'silentlyContinue'; Invoke-WebRequest [PASTEBIN] -OutFile C:\Windows\System32\auth.txt"


if not exist "C:\Windows\System32\auth.txt" echo An error has occured. Please disable antivirus and try again. & timeout /t 3 >nul & exit /b
for /f "tokens=2 delims==" %%A in ('wmic csproduct get uuid /format:value ^| find "="') do set uuid=%%A
if not exist "C:\Windows\System32\auth.txt" echo An error has occured. Please try again. & timeout /t 3 >nul & exit /b

find "%uuid%" C:\Windows\System32\auth.txt >nul
if "%errorlevel%"=="0" (goto success) else (goto fail)


:fail
del /f /q C:\Windows\System32\auth.txt
echo %uuid% | CLIP
echo Not Authenticated.
echo HWID copied to clipboard.
pause >nul


:success
del /f /q C:\Windows\System32\auth.txt
echo Authenticated.
pause >nul

::---------------------------------------------------------------------------------------------------------
