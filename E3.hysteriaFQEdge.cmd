cls
@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

>nul 2>&1 fltmc || (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -WorkingDirectory '%~dp0' -Verb RunAs"
  exit /b
)

title Hysteria Edge

echo 是否执行IP更新？IP更新可能导致IP被封，如果觉得速度没问题，第一次使用请先更新IP.
echo 5秒后自动跳过选择ip1更新，如ip1不能用，再选ip2、3...更新，更新后如不好用，请发邮件至 freeman105@gmail.com 反馈问题.
choice /C 12345 /T 15 /D 5 /M "Select:"
if errorlevel 5 goto startfq
if errorlevel 4 goto ip4
if errorlevel 3 goto ip3
if errorlevel 2 goto ip2
if errorlevel 1 goto ip1



:ip4
start /wait "" "%~dp0hysteria\ip_Update\ip_4.bat"
goto startfq

:ip3
start /wait "" "%~dp0hysteria\ip_Update\ip_3.bat"
goto startfq

:ip2
start /wait "" "%~dp0hysteria\ip_Update\ip_2.bat"
goto startfq

:ip1
start /wait "" "%~dp0hysteria\ip_Update\ip_1.bat"
goto startfq

:startfq
 
start "" /D "%~dp0hysteria" "%~dp0hysteria\hysteria-tun-windows-6.0-386.exe" -c "%~dp0hysteria\config.json"
echo 等待防火墙确认，请稍候...
IF EXIST %~dp0Browser\msedge.exe (
    start %~dp0Browser\msedge.exe --user-data-dir=%~dp0chrome-user-data --proxy-server="socks5://127.0.0.1:1080"  about:blank
) ELSE (
	%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" >nul 2>&1
	IF  not errorlevel 1 (
    start msedge.exe --user-data-dir=%~dp0chrome-user-data  --proxy-server="socks5://127.0.0.1:1080"   about:blank
	) else (
		echo Edge浏览器不存在或没有正确安装，请尝试重新安装Edge浏览器！
		echo 或者尝试下面的办法：
		echo 右键点击桌面上的Microsoft Edge图标，点属性，找到msedge.exe文件的路径，然后把那个目录下的msedge.exe 同目录下的所有 dll文件和文件夹 一起拷贝到ProgramProxy文件夹下的Browser目录里，然后再运行ProgramProxy的防火墙脚本。
		pause
	)
)
