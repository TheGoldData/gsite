@echo off

set "CURRENT_DIR=%cd%"
if not "%GOLDSITE_HOME%"=="" goto gotHome
set "GOLDSITE_HOME=%CURRENT_DIR%"
if exist "%GOLDSITE_HOME%\libs\install-guide.jar" goto okHome
cd ..
set "GOLDSITE_HOME=%cd%"

cd "%CURRENT_DIR%"

:gotHome
if exist "%GOLDSITE_HOME%\libs\install-guide.jar" goto okHome
echo The GOLDSITE_HOME environment variable is not defined
goto end

:okHome

:end