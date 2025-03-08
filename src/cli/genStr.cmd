@echo off
setlocal enabledelayedexpansion

echo ----------------------------------------------------
echo Generate a String (Repeating Digits or Alphanumeric)
echo ----------------------------------------------------

:: 1) Prompt for length
echo Enter the desired length of the string:
set /p LENGTH=:
if "%LENGTH%"=="" set "LENGTH=8"

:: 2) Prompt user for type of string
echo.
echo What type of string do you want?
echo [1] Repeating digits (0-9)
echo [2] Random alphanumeric (a-z, A-Z, 0-9)
set /p CHOICE=Enter 1 or 2, then press [Enter]:

if "%CHOICE%"=="1" (
    goto RepeatingDigits
) else if "%CHOICE%"=="2" (
    goto RandomAlphanumeric
) else (
    echo Invalid choice. Exiting.
    exit /b 1
)

:: --------------------------------------------
:: Generate repeating digits ("0-9" repeated)
:: --------------------------------------------
:RepeatingDigits
set "DIGITS=0123456789"
set "RESULT="
for /l %%I in (1,1,%LENGTH%) do (
    :: Determine which digit to use based on index
    set /a "IDX=(%%I-1) %% 10"
    set "RESULT=!RESULT!!DIGITS:~%IDX%,1!"
)
goto OutputAndExit

:: --------------------------------------------
:: Generate random alphanumeric string
:: --------------------------------------------
:RandomAlphanumeric
set "ALPHANUM=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
set "RESULT="
for /l %%I in (1,1,%LENGTH%) do (
    set /a INDEX=!RANDOM! %% 62
    set "RESULT=!RESULT!!ALPHANUM:~%INDEX%,1!"
)
goto OutputAndExit

:: --------------------------------------------
:: Output the result and copy to clipboard
:: --------------------------------------------
:OutputAndExit
echo.
echo Generated String:
echo !RESULT!
echo.
echo (Copied to clipboard)
echo !RESULT! | clip

pause
exit /b 0
