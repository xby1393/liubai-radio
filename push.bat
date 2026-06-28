@echo off
chcp 65001 >nul 2>&1

set "GIT_PATH="
if exist "C:\Program Files\Git\bin\git.exe" set "GIT_PATH=C:\Program Files\Git\bin\"
if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT_PATH=C:\Program Files (x86)\Git\bin\"

cd /d E:\miclaw\project\liubai-radio
if %errorlevel% neq 0 (
    echo [ERROR] Cannot enter project directory
    pause
    exit /b 1
)

echo [1/3] Adding files...
"%GIT_PATH%git" add .

echo [2/3] Committing...
"%GIT_PATH%git" commit -m "update %date%"

echo [3/3] Pushing to GitHub...
"%GIT_PATH%git" push

if %errorlevel% equ 0 (
    echo.
    echo [OK] Push success!
) else (
    echo.
    echo [FAIL] Push failed, check network
)

pause
