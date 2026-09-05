@echo off
chcp 65001 >nul 2>&1
setlocal EnableExtensions EnableDelayedExpansion

rem 尽量避免乱码；失败也不影响运行

cd /d "%~dp0"

rem =========================
rem  管理员判断（最稳）
rem =========================
net session >nul 2>&1 && goto :after_elevate

rem 如果已经带 ELEVATED 参数，认为是管理员二次启动
if /i "%~1"=="ELEVATED" goto :after_elevate

rem =========================
rem  提权（mshta + 短路径）+ FLAG确认，避免“假成功闪退”
rem =========================
set "FLAG=%temp%\clashmeta_elev_%random%%random%.flag"
> "%FLAG%" echo 1

where mshta.exe >nul 2>&1
if not errorlevel 1 (
  rem 用短路径 %~s0，提高兼容性（类似你的老版本）
  mshta "vbscript:CreateObject(""Shell.Application"").ShellExecute(""cmd.exe"",""/c """"%~s0"""" ELEVATED """"%FLAG"""" "","""",""runas"",1)(close)"
)

rem 等待管理员实例启动并删除FLAG（约1秒）
ping 127.0.0.1 -n 1 -w 200 >nul

rem 如果 FLAG 被删，说明管理员实例已成功启动 → 普通窗口退出避免双开
if not exist "%FLAG%" exit /b

rem FLAG 还在：说明提权失败/用户点否/被策略拦截 → 继续用普通权限执行（不闪退）
goto :after_elevate


:after_elevate
rem 管理员实例会带第2参数 FLAG；先删除它，让普通实例知道“我真的起来了”
if not "%~2"=="" (
  del /f /q "%~2" >nul 2>&1
)
if not exist "%~dp0mieru" (
  echo [错误] 未找到目录：%~dp0mieru
  echo 请先完整解压到本地磁盘，不要在压缩包内直接运行。
  pause
  exit /b
)
if not exist "%~dp0mieru\mieru.exe" (
  echo [错误] 未找到：%~dp0mieru\mieru.exe
  echo 可能被安全软件隔离/删除，请检查防毒软件的隔离/历史并加入排除项。
  pause
  exit /b
)

rem -------------------------

title Mieru 一键启动

echo 是否执行IP更新？IP更新从云端更新IP配置以解决封锁问题！
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
echo 等待翻墙软件启动，请稍候...
IF EXIST %~dp0Browser\chrome.exe (
    start %~dp0Browser\chrome.exe --user-data-dir=%~dp0chrome-user-data --proxy-server="socks5://127.0.0.1:3080"  about:blank
) ELSE (
	%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" >nul 2>&1
	IF  not errorlevel 1 (
    start chrome.exe --user-data-dir=%~dp0chrome-user-data  --proxy-server="socks5://127.0.0.1:3080"   about:blank
	) else (
		echo Chrome浏览器不存在或没有正确安装，请尝试重新安装Chrome浏览器
		echo 或者采用以下办法：
		echo 右键点桌面的Google Chrome图标，再点属性，找到chrome.exe文件的路径，然后打开那个目录，把chrome.exe 连同那个目录下的所有子文件夹和文件，一起拷贝到ProgramProxy文件夹下的Browser目录里面，然后重新启动ProgramProxy的翻墙脚本。
		pause
	)
)