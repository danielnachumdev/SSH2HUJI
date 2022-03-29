@echo off
SET me=%~n0


:update
set current_version=1.01
set version_file=tmp
echo [%me%] Cheking version number...
curl --silent --output %version_file% https://raw.githubusercontent.com/danielnachumdev/SSH2HUJI/main/version
set count=0
FOR /F "tokens=1" %%x IN (%version_file%) DO (
    if %count%==0 ( rem this is to check the version if this is a .bat file
        if %current_version% LSS %%x (
            echo [%me%] LATEST VERSION=%%x
            echo [%me%] CURRENT_VERSION=%current_version%
            echo [%me%] go to https://github.com/danielnachumdev/SSH2HUJI to download the latest version
            del tmp
            goto exit
        ) else (
          echo [%me%] good to go!
          del tmp
          goto login
        )
    )
    set %count%=%count%+1
)


:login
set /p user=[%me%] Enter CSE username:
ssh -CXJ %user%@bava.cs.huji.ac.il %user%@river-01

:exit
pause