@echo off
SET THEFILE=C:\Users\valde\Documents\FluxoCaixa\Fluxocaixa.exe
echo Linking %THEFILE%
C:\lazarus\fpc\3.2.2\bin\i386-win32\ld.exe -b pei-i386 -m i386pe  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o C:\Users\valde\Documents\FluxoCaixa\Fluxocaixa.exe C:\Users\valde\Documents\FluxoCaixa\link6548.res
if errorlevel 1 goto linkend
C:\lazarus\fpc\3.2.2\bin\i386-win32\postw32.exe --subsystem gui --input C:\Users\valde\Documents\FluxoCaixa\Fluxocaixa.exe --stack 16777216
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
