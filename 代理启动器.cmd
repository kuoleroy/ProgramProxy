@echo off
chcp 936 >nul
cd /d "%~dp0"

title Proxy Launcher

echo ========================================
echo   1. Clash.Meta  (HTTP 7890)
echo   2. Xray        (SOCKS5 1080)
echo   3. SingBox     (SOCKS5 1080)
echo   4. Hysteria    (SOCKS5 1080)
echo   5. Use existing proxy
echo ========================================
choice /C 12345 /T 30 /D 5 /M "Select proxy (1-5):"

if errorlevel 5 goto noproxy
if errorlevel 4 goto hysteria
if errorlevel 3 goto singbox
if errorlevel 2 goto xray
if errorlevel 1 goto clash

:clash
start "" /D "%~dp0clash.meta" "%~dp0clash.meta\clash.meta-windows-386.exe" -d "%~dp0clash.meta"
set HTTP_PROXY=http://127.0.0.1:7890
set HTTPS_PROXY=http://127.0.0.1:7890
set ALL_PROXY=socks5://127.0.0.1:7890
goto pickapp

:xray
start "" /D "%~dp0Xray" "%~dp0Xray\xray.exe" -c "%~dp0Xray\config.json"
set HTTP_PROXY=socks5://127.0.0.1:1080
set HTTPS_PROXY=socks5://127.0.0.1:1080
set ALL_PROXY=socks5://127.0.0.1:1080
goto pickapp

:singbox
start "" /D "%~dp0singbox" "%~dp0singbox\sing-box.exe" run -c "%~dp0singbox\config.json"
set HTTP_PROXY=socks5://127.0.0.1:1080
set HTTPS_PROXY=socks5://127.0.0.1:1080
set ALL_PROXY=socks5://127.0.0.1:1080
goto pickapp

:hysteria
start "" /D "%~dp0hysteria" "%~dp0hysteria\hysteria-tun-windows-6.0-386.exe" -c "%~dp0hysteria\config.json"
set HTTP_PROXY=socks5://127.0.0.1:1080
set HTTPS_PROXY=socks5://127.0.0.1:1080
set ALL_PROXY=socks5://127.0.0.1:1080
goto pickapp

:noproxy
set HTTP_PROXY=http://127.0.0.1:7890
set HTTPS_PROXY=http://127.0.0.1:7890
set ALL_PROXY=socks5://127.0.0.1:1080
goto pickapp

:pickapp
echo.
echo Waiting for proxy...
timeout /t 3 /nobreak >nul
echo.
set /P APPPATH="Drag the exe here or input full path: "
set APPPATH=%APPPATH:"=%
powershell -NoProfile -Command "Start-Process -FilePath '%APPPATH%'"
echo Started. You can close this window, the program keeps running.
pause
