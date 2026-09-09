@echo off
rem ============================================================================
rem copytosteam.bat
rem Copies the freshly built deferred mod (mod_episodic) into the Steam install
rem so it can be run directly from Steam. Adjust the variables below to match
rem your machine, then run this after a successful build.
rem ============================================================================

setlocal

rem --- Root of your Steam library that contains sourcemods -------------------
set STEAM_LIBRARY=D:\SteamLibrary

rem --- Mod folder inside the Steam library (sourcesdk or a mod install) ------
set DEST=%STEAM_LIBRARY%\steamapps\sourcemods\mod_episodic

rem --- Built mod folder in this repository -----------------------------------
set SRC=%~dp0..\game\mod_episodic

rem --- Build output folders (Release by default; change to Debug_*) ---------
set CLIENT_DLL=%~dp0game\client\Release_mod_episodic\client.dll
set SERVER_DLL=%~dp0game\server\Release_mod_episodic\server.dll
set SHADER_DLL=%~dp0materialsystem\stdshaders\Release_dx9_mod_episodic\game_shader_dx9.dll
set GAMEUI_DLL=%~dp0game\gameui2\Release_mod_episodic\gameui2.dll

if not exist "%DEST%" (
    echo Destination "%DEST%" does not exist.
    echo Edit the variables at the top of this script and try again.
    exit /b 1
)

echo Copying %SRC% -^> %DEST%

rem --- Compiled shaders ------------------------------------------------------
if exist "%SRC%\shaders\fxc" (
    robocopy "%SRC%\shaders\fxc" "%DEST%\shaders\fxc" /E /NFL /NDL /NJH /NJS >nul
)

rem --- Materials, resource, scripts, cfg ------------------------------------
for %%D in (materials resource scripts cfg maps) do (
    if exist "%SRC%\%%D" (
        robocopy "%SRC%\%%D" "%DEST%\%%D" /E /NFL /NDL /NJH /NJS >nul
    )
)

rem --- Built DLLs ------------------------------------------------------------
if exist "%CLIENT_DLL%" copy /y "%CLIENT_DLL%" "%DEST%\bin\client.dll" >nul
if exist "%SERVER_DLL%" copy /y "%SERVER_DLL%" "%DEST%\bin\server.dll" >nul
if exist "%SHADER_DLL%" copy /y "%SHADER_DLL%" "%DEST%\bin\game_shader_dx9.dll" >nul
if exist "%GAMEUI_DLL%" copy /y "%GAMEUI_DLL%" "%DEST%\bin\gameui2.dll" >nul

echo Done.
endlocal
exit /b 0
