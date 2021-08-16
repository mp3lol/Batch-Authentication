:: This is a simple script created for making auth in batch.
:: It's not revolutionary, or anything. I just made it for fun.
:: Replace '[PASTEBIN]' with your raw pastebin link using ctrl+h.
:: Make sure your pastebin is editable and you seperate HWID's per line.
:: Created by mp3#9999 on Discord


::---------------------------------------------------------------------------------------------------------

@echo off

 :check
ping www.google.com -n 1 -w 1000 >nul
if errorlevel 1 (echo An error has occured. Please connect to internet and try again. & timeout /t 3 >nul & exit /b) else (goto :connected)

 :connected
for /f %%A in ('curl -k -s [PASTEBIN]') do set "auth=%%A"

 :hwidvars
for /f "tokens=2 delims==" %%A in ('wmic csproduct get uuid /format:value ^| find "="') do set uuid=%%A
for /f "tokens=2 delims==" %%A in ('wmic diskdrive get serialnumber /format:value ^| find "="') do set numb=%%A
for /f "tokens=2 delims==" %%A in ('wmic baseboard get serialnumber /format:value ^| find "="') do set board=%%A

 :auth
set hwid=%board%%uuid%%numb%
if "%auth%"=="%hwid%" (goto :success) else (goto :fail)

 :success
echo Authenticated.
timeout /t 4 >nul & exit /b

 :fail
echo %hwid% | CLIP
echo Not Authenticated.
echo HWID copied to clipboard. & timeout /t 4 >nul & exit /b

::---------------------------------------------------------------------------------------------------------
