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
>> "%~dp0Firefox-Profile\user.js" echo user_pref("browser.startup.homepage", "https://www.google.com/");
cls

title SingBox Firefox

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
IF EXIST "%ProgramFiles%\Mozilla Firefox\firefox.exe" (
    start "" "%ProgramFiles%\Mozilla Firefox\firefox.exe" -no-remote -profile "%~dp0Firefox-Profile" https://www.google.com/
) ELSE IF EXIST "%ProgramFiles(x86)%\Mozilla Firefox\firefox.exe" (
    start "" "%ProgramFiles(x86)%\Mozilla Firefox\firefox.exe" -no-remote -profile "%~dp0Firefox-Profile" https://www.google.com/
) ELSE (
    %SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe" >nul 2>&1
    IF not errorlevel 1 (
        start firefox.exe -no-remote -profile "%~dp0Firefox-Profile" https://www.google.com/
    ) else (
        echo System Firefox not found, please install Firefox first.
        pause
    )
)
