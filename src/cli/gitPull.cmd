@echo off
setlocal

REM Change to the directory where the script is located
cd /d %~dp0

REM Loop through each child directory one level deep
for /d %%D in (*) do (
    if exist "%%D\.git" (
        echo Pulling in %%D
        cd %%D
        git pull
        cd ..
    )
)
endlocal
