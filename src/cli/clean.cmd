@echo off
setlocal enabledelayedexpansion

:: Define the list of folders
set "folders[0]=C:\Temp"
set "folders[1]=C:\Windows\Temp"
set "folders[2]=C:\Users\%USERNAME%\AppData\Local\Temp"

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

:: Clean up Visual Studio ComponentModelCache
set "visualStudioFolder=C:\Users\%USERNAME%\AppData\Local\Microsoft\VisualStudio"
echo %visualStudioFolder
for /d %%G in ("%visualStudioFolder%\[0-9][0-9]*") do (
    if exist "%%G\ComponentModelCache" (
        echo Deleting contents of %%G\ComponentModelCache
        del /q "%%G\ComponentModelCache\*" 2>nul
        for /d %%H in ("%%G\ComponentModelCache\*") do (
            rd /s /q "%%H" 2>nul
        )
    )
)
endlocal
pause