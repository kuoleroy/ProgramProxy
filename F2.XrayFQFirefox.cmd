@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"

>nul 2>&1 fltmc || (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -WorkingDirectory '%~dp0' -Verb RunAs"
  exit /b
)
> "%~dp0Firefox-Profile\user.js" echo user_pref("network.proxy.http", "");
>> "%~dp0Firefox-Profile\user.js" echo user_pref("network.proxy.http_port", 0);
>> "%~dp0Firefox-Profile\user.js" echo user_pref("network.proxy.ssl", "");
>> "%~dp0Firefox-Profile\user.js" echo user_pref("network.proxy.ssl_port", 0);
>> "%~dp0Firefox-Profile\user.js" echo user_pref("network.proxy.ftp", "");
>> "%~dp0Firefox-Profile\user.js" echo user_pref("network.proxy.ftp_port", 0);
>> "%~dp0Firefox-Profile\user.js" echo user_pref("network.proxy.share_proxy_settings", false);
>> "%~dp0Firefox-Profile\user.js" echo user_pref("network.proxy.socks", "127.0.0.1");
>> "%~dp0Firefox-Profile\user.js" echo user_pref("network.proxy.socks_port", 1080);
>> "%~dp0Firefox-Profile\user.js" echo user_pref("network.proxy.socks_remote_dns", true);
>> "%~dp0Firefox-Profile\user.js" echo user_pref("network.proxy.type", 1);
>> "%~dp0Firefox-Profile\user.js" echo user_pref("network.dns.disablePrefetch", true);
>> "%~dp0Firefox-Profile\user.js" echo user_pref("browser.startup.homepage", "about:blank");
cls

title Xray Firefox

echo 是否执行IP更新？IP更新可能导致IP被封，如果觉得速度没问题，第一次使用请先更新IP.
echo 5秒后自动跳过选择ip1更新，如ip1不能用，再选ip2、3...更新，更新后如不好用，请发邮件至freeman105@gmail.com 反馈问题.
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
IF EXIST "%ProgramFiles%\Mozilla Firefox\firefox.exe" (
    start "" "%ProgramFiles%\Mozilla Firefox\firefox.exe" -no-remote -profile "%~dp0Firefox-Profile" about:blank
) ELSE IF EXIST "%ProgramFiles(x86)%\Mozilla Firefox\firefox.exe" (
    start "" "%ProgramFiles(x86)%\Mozilla Firefox\firefox.exe" -no-remote -profile "%~dp0Firefox-Profile" about:blank
) ELSE (
    %SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe" >nul 2>&1
    IF not errorlevel 1 (
        start firefox.exe -no-remote -profile "%~dp0Firefox-Profile" about:blank
    ) else (
        echo System Firefox not found, please install Firefox first.
        pause
    )
)
