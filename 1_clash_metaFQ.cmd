cls
@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

>nul 2>&1 fltmc || (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -WorkingDirectory '%~dp0' -Verb RunAs"
  exit /b
)

title Clash.Meta One-Click Launcher

echo Update IP now? IP update fetches new configs from cloud to fix blocking. First time users MUST update.
echo Press 7 to skip, 1 for ip1 update. If ip1 bad, try ip2, ip3... If all fail, email freeman105@gmail.com
choice /C 1234567 /T 17 /D 7 /M "Select:"
if errorlevel 7 goto startfq
if errorlevel 6 goto ip6
if errorlevel 5 goto ip5
if errorlevel 4 goto ip4
if errorlevel 3 goto ip3
if errorlevel 2 goto ip2
if errorlevel 1 goto ip1

:ip6
start /wait "" "%~dp0clash.meta\ip_Update\ip_6.bat"
goto startfq

:ip5
start /wait "" "%~dp0clash.meta\ip_Update\ip_5.bat"
goto startfq

:ip4
start /wait "" "%~dp0clash.meta\ip_Update\ip_4.bat"
goto startfq

:ip3
start /wait "" "%~dp0clash.meta\ip_Update\ip_3.bat"
goto startfq

:ip2
start /wait "" "%~dp0clash.meta\ip_Update\ip_2.bat"
goto startfq

:ip1
start /wait "" "%~dp0clash.meta\ip_Update\ip_1.bat"
goto startfq

:startfq

start "" /D "%~dp0clash.meta" "%~dp0clash.meta\clash.meta-windows-386.exe" -d "%~dp0clash.meta"
echo Waiting for proxy to start, please wait...
IF EXIST %~dp0Browser\chrome.exe (
    start %~dp0Browser\chrome.exe --user-data-dir=%~dp0chrome-user-data --proxy-server=127.0.0.1:7890 about:blank
) ELSE (
	%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" >nul 2>&1
	IF  not errorlevel 1 (
    start chrome.exe --user-data-dir=%~dp0chrome-user-data  --proxy-server=127.0.0.1:7890 about:blank
	) else (
		echo Chrome not found or not installed correctly. Try reinstalling Chrome.
		echo Or try this:
		echo Right-click Chrome icon > Properties > find chrome.exe path. Copy chrome.exe and all files/folders in that directory to ProgramProxy\Browser folder, then restart the script.
		pause
	)
)