@echo off
setlocal

rem Use dynamic shaders to build .inc files only
rem set dynamic_shaders=1
rem == Setup path to nmake.exe, from vc 2005 common tools directory ==
<<<<<<< HEAD
call "%VS120COMNTOOLS%vsvars32.bat"
=======
call "%VS100COMNTOOLS%vsvars32.bat"
>>>>>>> 3923b343f72dccd8c59026259149fbb31e60d3b0


set TTEXE=..\..\devtools\bin\timeprecise.exe
if not exist %TTEXE% goto no_ttexe
goto no_ttexe_end

:no_ttexe
set TTEXE=time /t
:no_ttexe_end


rem echo.
rem echo ~~~~~~ buildsdkshaders %* ~~~~~~
%TTEXE% -cur-Q
set tt_all_start=%ERRORLEVEL%
set tt_all_chkpt=%tt_start%

set BUILD_SHADER=call buildshaders.bat
set ARG_EXTRA=

rem %BUILD_SHADER% stdshader_dx9_20b		-game %GAMEDIR% -source %SOURCEDIR%
rem %BUILD_SHADER% stdshader_dx9_30			-game %GAMEDIR% -source %SOURCEDIR% -dx9_30	-force30 
<<<<<<< HEAD
%BUILD_SHADER% deferred_shaders			-game %GAMEDIR% -source %SOURCEDIR%	-force30 
=======
%BUILD_SHADER% deferred_shaders			-game %GAMEDIR% -source %SOURCEDIR% -dx9_30	-force30 
>>>>>>> 3923b343f72dccd8c59026259149fbb31e60d3b0


rem echo.
if not "%dynamic_shaders%" == "1" (
  rem echo Finished full buildallshaders %*
) else (
  rem echo Finished dynamic buildallshaders %*
)

rem %TTEXE% -diff %tt_all_start% -cur
rem echo.
