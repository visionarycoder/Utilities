@echo off
setlocal enabledelayedexpansion

:: Define the list of folders
set "folders[0]=C:\Temp\"
set "folders[1]=C:\Windows\Temp\"
set "folders[2]=C:\Users\%USERNAME%\AppData\Local\Temp\"
set "folders[3]=C:\Users\%USERNAME%\AppData\Local\Microsoft\VisualStudio\17.0_eabb2e61\ComponentModelCache"
set "folders[4]=C:\Users\%USERNAME%\AppData\Local\Microsoft\VisualStudio\17.0_d80c39ec\ComponentModelCache"

:: Loop through each folder
set /a i=0
:loop
if defined folders[%i%] (
    set "target_folder=!folders[%i%]!"

    :: Check if the folder exists
    if exist "!target_folder!" (
        echo Deleting contents of !target_folder!...

        :: Remove all files in the folder
        del /q "!target_folder!\*.*"

        :: Remove all subdirectories in the folder
        for /d %%D in ("!target_folder!\*") do (
            rd /s /q "%%D"
        )
    )
    set /a i+=1
    goto loop
)

endlocal
pause