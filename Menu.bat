@echo off
for /f %%a in ('echo prompt $E^| cmd') do set "esc=%%a"

::____________________________ Timer start __________________________________

title Loading...

setlocal enabledelayedexpansion

rem pick random seconds between 3 and 6
set /a secs=%random% %% 4 + 3

set "start=%time%"

:spin
for %%s in (^| / - \) do (
    <nul set /p "=%%s"
    timeout /t 0 >nul
    <nul set /p "="
)

rem check elapsed time
set "now=%time%"
set /a elapsed = (1%now:~0,2% - 1%start:~0,2%) * 3600 ^
 + (1%now:~3,2% - 1%start:~3,2%) * 60 ^
 + (1%now:~6,2% - 1%start:~6,2%)

if !elapsed! LSS %secs% goto spin

echo.
endlocal
cls

::______________________________ Timer end _________________________________

:main
cls

title Main Menu

echo =============
echo   MAIN MENU
echo =============
echo. 
echo 1. Utility
echo 2. Tools
echo 3. Storage
echo 4. Backup
echo 5. Display
echo 6. Audio
echo 7. Account
echo 8. Help
echo 9. %esc%[31mExit%esc%[0m
choice /c 123456789 /n /m "Choose an option: "

if errorlevel 9 goto :end
if errorlevel 8 goto :help
if errorlevel 7 goto :account
if errorlevel 6 goto :audio
if errorlevel 5 goto :display
if errorlevel 4 goto :backup
if errorlevel 3 goto :storage
if errorlevel 2 goto :tools
if errorlevel 1 goto :utility

pause
goto :main

::_____________________________________________________________________________

:utility
cls

title Utility Menu

echo ===== Utility =====
echo 1. Clean temp files
echo 2. Flush DNS
echo 3. Show system info
echo 4. %esc%[31mBack%esc%[0m
choice /c 1234 /n /m "Choose an option: "

if errorlevel 4 goto main
if errorlevel 3 systeminfo
if errorlevel 2 ipconfig /flushdns
if errorlevel 1 del /q /f /s "%temp%\*"

pause
goto :utility

::_____________________________________________________________________________

:tools
cls

title Tools Menu

echo ===== TOOLS ======
echo 1. System Info
echo 2. Show IP info
echo 3. Task Manager
echo 4. %esc%[31mBack%esc%[0m
choice /c 1234 /n /m "Select: "

if errorlevel 4 goto main
if errorlevel 3 start taskmgr
if errorlevel 2 ipconfig
if errorlevel 1 systeminfo

pause
goto :tools

::______________________________________________________________________________

:storage
cls

title Storage Menu

echo ===== STORAGE =====
echo 1. C: drive
echo 2. D: drive
echo 3. Downloads
echo 4. Documents
echo 5. Desktop
echo 6. Pictures
echo 7. %esc%[31mBack%esc%[0m
echo.
choice /c 1234567 /n /m "Select: "

if errorlevel 7 goto main
if errorlevel 6 start "" "%userprofile%\Pictures"
goto :storage
if errorlevel 5 start "" "%userprofile%\Desktop"
goto :storage
if errorlevel 4 start "" "%userprofile%\Documents"
goto :storage
if errorlevel 3 start "" "%userprofile%\Downloads"
goto :storage
if errorlevel 2 start "" "D:\"
goto :storage
if errorlevel 1 start "" "C:\"

pause
goto :storage

::__________________________________________________________________________________

:backup
cls

title Backup Menu

echo ===== BACKUP =====
echo 1. Backup Documents to Desktop\Backup
echo 2. Backup Pictures to Desktop\Backup
echo 3. Backup Desktop to Desktop\Backup
echo 4. %esc%[31mBack%esc%[0m
echo.
choice /c 1234 /n /m "Select: "

set "backupdir=%userprofile%\Desktop\Backup"

if errorlevel 4 goto main
if errorlevel 3 (
    mkdir "%backupdir%" 2>nul
    xcopy "%userprofile%\Desktop" "%backupdir%\Desktop" /E /I /Y
    pause
)
if errorlevel 2 (
    mkdir "%backupdir%" 2>nul
    xcopy "%userprofile%\Pictures" "%backupdir%\Pictures" /E /I /Y
    pause
)
if errorlevel 1 (
    mkdir "%backupdir%" 2>nul
    xcopy "%userprofile%\Documents" "%backupdir%\Documents" /E /I /Y
    pause
)

pause
goto :backup

::___________________________________________________________________________________

:display
cls

title Display Menu

echo ===== DISPLAY =====
echo 1. Display settings
echo 2. Resolution (advanced)
echo 3. Night light / brightness settings
echo 4. Color management
echo 5. %esc%[31mBack%esc%[0m
echo.
choice /c 12345 /n /m "Select: "

if errorlevel 5 goto main
if errorlevel 4 start "" colorcpl
goto :display
if errorlevel 3 start "" ms-settings:display
goto :display
if errorlevel 2 start "" desk.cpl
goto :display
if errorlevel 1 start "" ms-settings:display

pause
goto :display

::_____________________________________________________________________________________

:audio
cls

title Audio Menu

echo ===== AUDIO =====
echo 1. Volume mixer
echo 2. Sound settings
echo 3. Test sound (beep)
echo 4. Playback devices
echo 5. %esc%[31mBack%esc%[0m
echo.
choice /c 12349 /n /m "Select: "

if errorlevel 5 goto main
if errorlevel 4 rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,0
goto :display
if errorlevel 3 powershell -Command "[console]::beep(1000,500)"
goto :display
if errorlevel 2 start "" ms-settings:sound
goto :display
if errorlevel 1 sndvol

pause
goto :audio

::_______________________________________________________________________________________

:account
cls

title Account Menu

echo ===== ACCOUNT =====
echo 1. Lock PC
echo 2. Switch user
echo 3. Sign out
echo 4. Open profile folder
echo 5. %esc%[31mBack%esc%[0m
echo.
choice /c 12345 /n /m "Select: "

if errorlevel 5 goto main
if errorlevel 4 start "" "%userprofile%"
goto :account
if errorlevel 3 shutdown /l
goto :account
if errorlevel 2 tsdiscon
goto :account
if errorlevel 1 rundll32.exe user32.dll,LockWorkStation

pause
goto :account

::________________________________________________________________________________________

:help
cls

title Help Menu

echo ===== HELP =====
echo Common shortcuts:
echo  - Win + E  = File Explorer
echo  - Win + D  = Show Desktop
echo  - Win + L  = Lock PC
echo  - Alt + Tab = Switch windows
echo  - Ctrl + Shift + Esc = Task Manager
echo.
echo Command examples:
echo  - ipconfig /all
echo  - ping 8.8.8.8
echo  - systeminfo
echo.
echo 1. %esc%[31mBack%esc%[0m
echo.
choice /c 1 /n /m "Press 1 to go back: "

if errorlevel 1 goto main
pause

::________________________________________________________________________________________

:end