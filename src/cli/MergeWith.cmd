@echo off
setlocal

:: ---------------------------------------------
:: 1. Script Directory Variable
::    %~dp0 includes a trailing backslash
:: ---------------------------------------------
set "SCRIPT_DIR=%~dp0"

:: ---------------------------------------------
:: 2. Detect Current Branch
:: ---------------------------------------------
for /f "delims=" %%i in ('git rev-parse --abbrev-ref HEAD 2^>nul') do (
    set "CURRENT_BRANCH=%%i"
)
if not defined CURRENT_BRANCH (
    echo Could not detect current Git branch. Are you in a Git repository?
    pause
    exit /b 1
)

:: ---------------------------------------------
:: 3. Load Previously Saved Settings (if any)
::    from MergeFrom.settings in the script's folder
:: ---------------------------------------------
if exist "%SCRIPT_DIR%MergeFrom.settings" (
    call :LOAD_SETTINGS
)

:: Fallback defaults if no saved values
:: Default Source Branch: main
if not defined SAVED_SOURCE_BRANCH set "SAVED_SOURCE_BRANCH=main"

:: Default Target Branch: current branch
if not defined SAVED_TARGET_BRANCH set "SAVED_TARGET_BRANCH=%CURRENT_BRANCH%"

:: ---------------------------------------------
:: 4. Prompt User for Source and Target Branch
:: ---------------------------------------------
echo Current branch detected: %CURRENT_BRANCH%

set /p SOURCE_BRANCH=Enter the name of the Source branch [%SAVED_SOURCE_BRANCH%]:
if "%SOURCE_BRANCH%"=="" set "SOURCE_BRANCH=%SAVED_SOURCE_BRANCH%"

set /p TARGET_BRANCH=Enter the name of the Target branch [%SAVED_TARGET_BRANCH%]:
if "%TARGET_BRANCH%"=="" set "TARGET_BRANCH=%SAVED_TARGET_BRANCH%"

:: ---------------------------------------------
:: 5. Save Updated Settings Immediately
::    (So they're saved even if the merge fails)
:: ---------------------------------------------
call :SAVE_SETTINGS

:: ---------------------------------------------
:: 6. Perform the Merge with Basic Error Checks
:: ---------------------------------------------
echo.
echo --- Merging %SOURCE_BRANCH% into %TARGET_BRANCH% ---
echo.

git checkout %SOURCE_BRANCH% || goto :MERGEFAILED
git pull origin %SOURCE_BRANCH% || goto :MERGEFAILED

git checkout %TARGET_BRANCH% || goto :MERGEFAILED
git merge %SOURCE_BRANCH% || goto :MERGEFAILED

echo.
echo Merge completed successfully.
pause
exit /b 0

:MERGEFAILED
echo.
echo Merge failed (see messages above).
pause
exit /b 1

:: =============================================
:: Subroutine: LOAD_SETTINGS
:: Reads lines from MergeFrom.settings:
::   SAVED_SOURCE_BRANCH=<...>
::   SAVED_TARGET_BRANCH=<...>
:: =============================================
:LOAD_SETTINGS
for /f "usebackq delims=" %%L in ("%SCRIPT_DIR%MergeFrom.settings") do (
    set %%L
)
:: echo [DEBUG] After loading settings:
:: echo SAVED_SOURCE_BRANCH=%SAVED_SOURCE_BRANCH%
:: echo SAVED_TARGET_BRANCH=%SAVED_TARGET_BRANCH%
exit /b

:: =============================================
:: Subroutine: SAVE_SETTINGS
:: Overwrites MergeFrom.settings with the new
::   SOURCE_BRANCH and TARGET_BRANCH
:: =============================================
:SAVE_SETTINGS
(
    echo SAVED_SOURCE_BRANCH=%SOURCE_BRANCH%
    echo SAVED_TARGET_BRANCH=%TARGET_BRANCH%
) > "%SCRIPT_DIR%MergeFrom.settings"
:: echo [DEBUG] Settings updated.
exit /b
