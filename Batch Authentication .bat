:: This is a simple script created for making auth in batch.
:: It's not revolutionary, or anything. I just made it for fun.
:: Replace '[PASTEBIN]' with your raw pastebin link using ctrl+h.
:: Make sure your pastebin is editable and you seperate HWID's per line.
:: Created by mp3#9999 on Discord


::---------------------------------------------------------------------------------------------------------

@echo off

::powershell commands
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
powershell -Command "Invoke-WebRequest [PASTEBIN] -OutFile C:\Windows\System32\auth1.txt"

::setting variables
for /f "tokens=2 delims==" %%A in ('wmic csproduct get uuid /format:value ^| find "="') do set uuid=%%A
setlocal enabledelayedexpansion
set content=
for /F "delims=" %%i in (C:\Windows\System32\auth1.txt) do set content=!content! %%i

::auth
find "%uuid%" C:\Windows\System32\auth1.txt >nul
if "%errorlevel%"=="0" (
  echo Authenticated.
) else (
  echo %uuid% | CLIP
  echo Not Authenticated.
  echo HWID copied to clipboard.
)

::extra
del /f /q C:\Windows\System32\auth1.txt
pause >nul

::---------------------------------------------------------------------------------------------------------

