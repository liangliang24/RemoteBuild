@echo off
cd /d %~dp0
cd ..
set PROJ_NAME=NetCoding
set USER=lltouchingfish
set PASSWORD=lltouchingfish
set HOST=192.168.48.128
set PORT=22
set LOCAL_DIR=%CD%
set REMOTE_DIR=./dev/%PROJ_NAME%
set PSCP=.\RemoteBuild\pscp.exe
set PLINK=.\RemoteBuild\plink.exe

%PLINK% %USER%@%HOST% -pw %PASSWORD% "mkdir %REMOTE_DIR%"

:: 上传整个文件夹
%PSCP% -r -P %PORT% -pw %PASSWORD% %LOCAL_DIR%/src %USER%@%HOST%:%REMOTE_DIR%
%PSCP% -r -P %PORT% -pw %PASSWORD% %LOCAL_DIR%/premake5 %USER%@%HOST%:%REMOTE_DIR%
%PSCP% -r -P %PORT% -pw %PASSWORD% %LOCAL_DIR%/premake5.lua %USER%@%HOST%:%REMOTE_DIR%

:: 编译并运行（可选，根据上传内容修改）
%PLINK% -t -ssh %USER%@%HOST% -P %PORT% -pw %PASSWORD% "cd %REMOTE_DIR% && premake5 gmake && make"

pause
