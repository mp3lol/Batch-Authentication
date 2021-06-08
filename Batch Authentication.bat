:: This is a simple script created for making auth in batch.
:: It's not revolutionary, or anything. I just made it for fun.
:: Replace '[PASTEBIN]' with your raw pastebin link using ctrl+h.
:: Make sure your pastebin is editable and you seperate HWID's per line.
:: Created by mp3#9999 on Discord


::---------------------------------------------------------------------------------------------------------

@echo off


:check
ping www.google.com -n 1 -w 1000 >nul
if errorlevel 1 (echo An error has occured. Please connect to internet and try again. & timeout /t 3 >nul & exit /b) else (goto connected)


:connected
curl -s [PASTEBIN] > C:\Users\%username%\AppData\Local\Temp\auth.txt
if not exist "C:\Users\%username%\AppData\Local\Temp\auth.txt" echo An error has occured. Please disable antivirus and try again. & timeout /t 3 >nul & exit /b


:hwidvars
for /f "tokens=2 delims==" %%A in ('wmic csproduct get uuid /format:value ^| find "="') do set uuid=%%A
for /f "tokens=2 delims==" %%A in ('wmic diskdrive get serialnumber /format:value ^| find "="') do set numb=%%A
for /f "tokens=2 delims==" %%A in ('wmic baseboard get serialnumber /format:value ^| find "="') do set board=%%A


:auth
if not exist "C:\Users\%username%\AppData\Local\Temp\auth.txt" echo An error has occured. Please try again. & timeout /t 3 >nul & exit /b
set hwid=%board%%uuid%%numb%
find "%hwid%" C:\Users\%username%\AppData\Local\Temp\auth.txt >nul & goto check
exit /b


:check
if "%errorlevel%"=="0" (goto success) else (goto fail)


:fail
del /f /q C:\Users\%username%\AppData\Local\Temp\auth.txt
echo %hwid% | CLIP
echo Not Authenticated.
echo HWID copied to clipboard.
pause >nul


:success
del /f /q C:\Users\%username%\AppData\Local\Temp\auth.txt
echo Authenticated.
pause >nul

::---------------------------------------------------------------------------------------------------------
