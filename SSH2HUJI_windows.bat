@echo off
SET me=SSH2HUJI
where curl >nul 2>&1 || (
    echo curl is not installed. Please install it and try again.
    exit /b 1
)

where ssh >nul 2>&1 || (
    echo ssh is not installed. Please install it and try again.
    exit /b 1
)

:update
set current_version=1.10
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
            del %version_file%
        ) else (
          echo [%me%] good to go!
          del %version_file%
        )
    )
    set /a count=%count%+1
)

set known_hosts=C:\Users\%USERNAME%\.ssh\known_hosts
set look_for="bava.cs.huji.ac.il"
:login
@REM does known_hosts already contains path?
find %look_for% %known_hosts% > nul && (
    @REM do nothing it already exists
) || (
    echo first time setup may take a few seconds...
    ssh-keyscan -t rsa bava.cs.huji.ac.il >> %known_hosts%
)
set /p user=[%me%] Enter CSE username:
ssh -CXJ %user%@bava.cs.huji.ac.il %user%@river-01

:exit
pause