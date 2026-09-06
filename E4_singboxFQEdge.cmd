cls
@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

>nul 2>&1 fltmc || (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -WorkingDirectory '%~dp0' -Verb RunAs"
  exit /b
)

title SingBox Edge

echo 是否执行IP更新？IP更新可能导致IP被封，如果觉得速度没问题，希望你选择IP更新.
echo 3秒后自动跳过选择ip1更新，如ip1不能用，再选ip2更新，更新后如不好用，请发邮件至freeman105@gmail.com反馈问题.
choice /C 123 /T 15 /D 3 /M "Select:"
if errorlevel 3 goto startfq
if errorlevel 2 goto ip2
if errorlevel 1 goto ip1

:ip2
start /wait "" "%~dp0singbox\ip_Update\ip_2.bat"
goto startfq

:ip1
start /wait "" "%~dp0singbox\ip_Update\ip_1.bat"
goto startfq

:startfq

start "" /D "%~dp0singbox" "%~dp0singbox\sing-box.exe" run -c "%~dp0singbox\config.json"

echo 等待防火墙确认，请稍候...
IF EXIST %~dp0Browser\msedge.exe (
    start %~dp0Browser\msedge.exe --user-data-dir=%~dp0chrome-user-data --proxy-server="socks5://127.0.0.1:1080"  https://www.google.com/
) ELSE (
	%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" >nul 2>&1
	IF  not errorlevel 1 (
    start msedge.exe --user-data-dir=%~dp0chrome-user-data  --proxy-server="socks5://127.0.0.1:1080"   https://www.google.com/
	) else (
		echo Edge not found or not installed correctly. Try reinstalling Edge.！
		echo 或者尝试下面的办法：
		echo 右键点击桌面上的Microsoft Edge图标，点属性，找到msedge.exe文件的路径，然后把那个目录下的msedge.exe 同目录下的所有 dll文件和文件夹 一起拷贝到ProgramProxy文件夹下的Browser目录里，然后再运行ProgramProxy的防火墙脚本。
		pause
	)
)
