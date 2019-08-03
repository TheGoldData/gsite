@echo off
title GoldSite Scheme Change Assistant
rem  金色站点皮肤制作助手

setlocal

if exist "setenv.bat" goto okEnv

call "bin/setenv.bat"
goto gotEnv

:okEnv
call "setenv.bat"

:gotEnv
if exist "%GOLDSITE_HOME%\libs\install-guide.jar" goto okHome
echo The GOLDSITE_HOME environment variable is not defined
goto end

:okHome
call "%GOLDSITE_HOME%\bin\setclasspath.bat"

set _EXECJAVA=%_RUNJAVA%
set MAINCLASS=com.xst.golddata.app.DatabaseUpgrade
set CLASSPATH=".;%GOLDSITE_HOME%\libs\install-guide.jar"

%_EXECJAVA% -Dgoldsite.home="%GOLDSITE_HOME%" -classpath %CLASSPATH% %MAINCLASS% %1
:end