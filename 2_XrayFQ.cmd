cls
@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

>nul 2>&1 fltmc || (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -WorkingDirectory '%~dp0' -Verb RunAs"
  exit /b
)

title Xray One-Click Launcher

echo Update IP now? IP update fetches new configs from cloud to fix blocking. First time users MUST update.
echo 按5跳过，按1选择ip1更新，若ip1不好用再按2选ip2更新，如果更新后都用不了，请发邮件到freeman105@gmail.com进行反馈！
choice /C 12345 /T 15 /D 5 /M "Select:"
if errorlevel 5 goto startfq
if errorlevel 4 goto ip4
if errorlevel 3 goto ip3
if errorlevel 2 goto ip2
if errorlevel 1 goto ip1

:ip4
start /wait "" "%~dp0Xray\ip_Update\ip_4.bat"
goto startfq

:ip3
start /wait "" "%~dp0Xray\ip_Update\ip_3.bat"
goto startfq

:ip2
start /wait "" "%~dp0Xray\ip_Update\ip_2.bat"
goto startfq

:ip1
start /wait "" "%~dp0Xray\ip_Update\ip_1.bat"
goto startfq

:startfq

start "" /D "%~dp0Xray" "%~dp0Xray\xray.exe" -c "%~dp0Xray\config.json"
echo Waiting for proxy to start, please wait...
IF EXIST %~dp0Browser\chrome.exe (
    start %~dp0Browser\chrome.exe --user-data-dir=%~dp0chrome-user-data --proxy-server="socks5://127.0.0.1:1080"  about:blank
) ELSE (
	%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" >nul 2>&1
	IF  not errorlevel 1 (
    start chrome.exe --user-data-dir=%~dp0chrome-user-data  --proxy-server="socks5://127.0.0.1:1080"   about:blank
	) else ( 
		echo Chrome not found or not installed correctly. Try reinstalling Chrome.
		echo Or try this:
		echo Right-click Chrome icon > Properties > find chrome.exe path. Copy chrome.exe and all files/folders in that directory to ProgramProxy\Browser folder, then restart the script.
		pause
	)
)