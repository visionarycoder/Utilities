@echo off
setlocal enabledelayedexpansion

echo Removing unwanted files.
echo Last updated %DATE% %TIME%
echo.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Set Variables
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

set "start_time=%time%"
set "files_touched=0"
set "files_deleted=0"
set "dirs_touched=0"
set "dirs_deleted=0"
set "bytes_saved=0"
set "padding_length=0"
set "dev_root_folder=C:\Dev"

:: Temp folders
set "temp[0]=C:\Temp"
set "temp[1]=C:\Users\%USERNAME%\AppData\Local\Temp"
set "temp[2]=C:\Windows\Temp"

:: Logging folders
set "logging[0]=C:\Intel"
set "logging[1]=C:\Log"
set "logging[2]=C:\PerfLogs"

:: ComponentModelCache folders
set "vsFolder=C:\Users\%USERNAME%\AppData\Local\Microsoft\VisualStudio"
set /a i=0
for /d %%G in ("%vsFolder%\*") do (
    if exist "%%G\ComponentModelCache" (
        set "vsCache[%i%]=%%G\ComponentModelCache"
        set /a i+=1
    )
)

:: bin and obj folders
set /a i=0
for /r %dev_root_folder% %%F in (*.csproj) do (
    set "projectDir=%%~dpF"
    set "binAndObj[%i%]=!projectDir!bin"
    set /a i+=1
    set "binAndObj[%i%]=!projectDir!obj"
    set /a i+=1
)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Process Folders
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Process temp folders and recreate them
echo Deleting files from 'temp' folders
call :ProcessFolders temp yes
echo Finished processing temp folders.
echo.

:: Process logging folders (no recreation)
echo Deleting files from 'logging' folders
call :ProcessFolders logging no
echo Finished processing logging folders.
echo.

:: Clean up Visual Studio ComponentModelCache
echo Deleting Visual Studio ComponentModelCache...
call :ProcessFolders vsCache no
echo Finished.
echo.

:: Delete bin and obj folders
echo Deleting bin and obj folders in C:\Dev..."
call :ProcessFolders binAndObj no
echo Finished.
echo.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Print Summary
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Print final summary
call :CalculateRuntime
call :PrintSummary
exit /b
endlocal 

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Functions
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:ProcessFolders
:: Arguments: %1 = array name (e.g., temp, logging), %2 = recreate flag (yes/no)
setlocal EnableDelayedExpansion
set "folder_name=%~1"
set "recreate_folder=%~2"
set /a i=0
:folder_loop
if defined %folder_name%[%i%] (
    set "folder=!%folder_name%[%i%]!"
    ::echo Processing folder: !target_folder!
    call :ProcessDirectory "!folder!"

    if /i "%recreate_folder%"=="yes" (
        ::echo Recreated folder: !target_folder!
        mkdir "!folder!" >nul 2>nul
    )
    set /a i+=1
    goto folder_loop
)
endlocal
exit /b

:ProcessDirectory
:: Arguments: %1 = directory path
set "dir=%~1"
if exist "!dir!" (
    echo   Checking !dir!

    :: Increment `dirs_touched`
    set /a dirs_touched+=1

    :: Process files in the directory
    for /r "!dir!" %%F in (*) do (
        if exist "%%F" (
            set /a files_touched+=1
            call :GetFileSize "%%F"
            del /q "%%F" >nul 2>nul
            if not exist "%%F" (
                set /a bytes_saved+=filesize
                set /a files_deleted+=1
            )
        )
    )

    :: Remove the directory and increment `dirs_deleted`
    rd /s /q "!dir!" >nul 2>nul
    if not exist "!dir!" (
        set /a dirs_deleted+=1
    )
)
exit /b

:GetFileSize
:: Get file size
set "filesize=0"
for /f "usebackq tokens=3" %%a in (`dir /-c "%~1" 2^>nul ^| findstr /c:"file(s)"`) do (
    set "filesize=%%a"
)
set "filesize=!filesize:,=!"
exit /b

:PrintSummary
call :FindMaxLength "!dirs_touched! !dirs_deleted! !files_deleted! !files_touched! !bytes_saved!" padding_length
call :RightJustify !dirs_touched! justified_dirs_touched
call :RightJustify !dirs_deleted! justified_dirs_deleted
call :RightJustify !files_touched! justified_files_touched
call :RightJustify !files_deleted! justified_files_deleted
call :RightJustify !bytes_saved! justified_bytes_saved

echo Summary:
echo Start time:          %start_time%
echo End time:            %end_time%
echo Script runtime:      !runtime! seconds
echo Bytes saved:         !bytes_saved! bytes
echo.
echo Directories touched: %justified_dirs_touched%
echo Directories deleted: %justified_dirs_deleted%
echo Files touched:       %justified_files_touched%
echo Files deleted:       %justified_files_deleted%
exit /b

:RightJustify
:: Arguments: %1 = value to justify, %2 = variable to store result
set "value=%~1"
set "spaces="
for /l %%I in (1,1,%padding_length%) do set "spaces= !spaces!"
set "padded=!spaces!!value!"
:: Trim the final result to the correct width
set "padded=!padded:~-%padding_length%!"
set "%~2=!padded!"
exit /b

:FindMaxLength
:: Arguments: %1 = list of variables, %2 = variable to store the max length
setlocal EnableDelayedExpansion
set "max_length=0"
for %%V in (%~1) do (
    set "current=%%V"
    set "length=0"
    for /l %%I in (0,1,31) do if "!current:~%%I,1!" neq "" set /a length+=1
    if !length! gtr !max_length! set "max_length=!length!"
)
endlocal & set "%~2=%max_length%"
exit /b

:CalculateRuntime
:: Calculate runtime
set "end_time=%time%"
for /f "tokens=1,2,3 delims=:." %%a in ("%start_time%") do (
    set /a "start_sec=%%a*3600+%%b*60"
    if "%%c" neq "" set /a "start_sec+=%%c"
)
for /f "tokens=1,2,3 delims=:." %%a in ("%end_time%") do (
    set /a "end_sec=%%a*3600+%%b*60"
    if "%%c" neq "" set /a "end_sec+=%%c"
)
set /a runtime=end_sec-start_sec
exit /b