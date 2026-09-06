cls
@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

>nul 2>&1 fltmc || (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -WorkingDirectory '%~dp0' -Verb RunAs"
  exit /b
)

title Mieru One-Click Launcher

echo Update IP now? IP update fetches new configs from cloud to fix blocking. First time users MUST update.
echo 按3跳过，按1选择ip1更新，若ip1不好用再按2选ip2更新，如果更新后都用不了，请发邮件到freeman105@gmail.com进行反馈！
choice /C 123 /T 15 /D 3 /M "Select:"
if errorlevel 3 goto startfq
if errorlevel 2 goto ip2
if errorlevel 1 goto ip1

:ip2
start /wait "" "%~dp0mieru\ip_Update\ip_2.bat"
goto startfq

:ip1
start /wait "" "%~dp0mieru\ip_Update\ip_1.bat"
goto startfq

:startfq

start "" /D "%~dp0mieru" "%~dp0mieru\mieru.exe" apply config "%~dp0mieru\config.json"
start "" /D "%~dp0mieru" "%~dp0mieru\mieru.exe" start
echo Waiting for proxy to start, please wait...
IF EXIST %~dp0Browser\chrome.exe (
    start %~dp0Browser\chrome.exe --user-data-dir=%~dp0chrome-user-data --proxy-server="socks5://127.0.0.1:3080"  https://www.google.com/
) ELSE (
	%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" >nul 2>&1
	IF  not errorlevel 1 (
    start chrome.exe --user-data-dir=%~dp0chrome-user-data  --proxy-server="socks5://127.0.0.1:3080"   https://www.google.com/
	) else (
		echo Chrome not found or not installed correctly. Try reinstalling Chrome.
		echo Or try this:
		echo Right-click Chrome icon > Properties > find chrome.exe path. Copy chrome.exe and all files/folders in that directory to ProgramProxy\Browser folder, then restart the script.
		pause
	)
)