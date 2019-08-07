



@echo off



title GOLDSITE Server Installer and Configurer

rem  金色数据配制安装程序

setlocal

if exist "setenv.bat" goto okEnv

call "bin\\setenv.bat"
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
set MAINCLASS=com.xst.golddata.Application
set CLASSPATH=".;%GOLDSITE_HOME%\libs\install-guide.jar"

%_EXECJAVA% -Dgoldsite.home="%GOLDSITE_HOME%" -classpath %CLASSPATH% %MAINCLASS%
:end