@echo off

rem Clean
echo Purpose: delete temp files from specifiec locations
echo Starting...
echo -----------------------------------------------------------------------

echo %SYSTEMROOT%\Temp
forfiles /P "%SYSTEMROOT%\Temp" /C "cmd /c if @isdir==TRUE rmdir /s /q @PATH"

echo -----------------------------------------------------------------------

echo %LOCALAPPDATA%\Temp
forfiles /P "%LOCALAPPDATA%\Temp" /C "cmd /c if @isdir==TRUE rmdir /s /q @PATH"

echo -----------------------------------------------------------------------

echo %APPDATA%\Temp
forfiles /P "%APPDATA%\Temp" /C "cmd /c if @isdir==TRUE rmdir /s /q @PATH"

echo -----------------------------------------------------------------------

echo %LOCALAPPDATA%\Microsoft\VisualStudio\17.0_2aeb11fe\ComponentModelCache
forfiles /P "%LOCALAPPDATA%\Microsoft\VisualStudio\17.0_2aeb11fe\ComponentModelCache" /C "cmd /c erase @PATH"

echo -----------------------------------------------------------------------
echo Finished
