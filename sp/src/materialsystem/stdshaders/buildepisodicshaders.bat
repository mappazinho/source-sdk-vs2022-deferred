@echo off
setlocal

rem ================================
rem ==== MOD PATH CONFIGURATIONS ===

rem == Set the absolute path to your mod's game directory here ==
<<<<<<< HEAD
set GAMEDIR=C:\Users\tempu\Desktop\source-sdk-vs2022-deferred-master\sp\game\mod_episodic
=======
set GAMEDIR=%cd%\..\..\..\game\mod_episodic
>>>>>>> 3923b343f72dccd8c59026259149fbb31e60d3b0

rem == Set the relative or absolute path to Source SDK Base 2013 Singleplayer\bin ==
set SDKBINDIR=D:\SteamBeta\SteamApps\common\Source SDK Base 2013 Singleplayer\bin

rem ==  Set the Path to your mod's root source code ==
rem This should already be correct, accepts relative paths only!
set SOURCEDIR=..\..

rem ==== MOD PATH CONFIGURATIONS END ===
rem ====================================


call buildsdkshaders.bat
<<<<<<< HEAD
pause
=======
>>>>>>> 3923b343f72dccd8c59026259149fbb31e60d3b0
