@echo off
SETLOCAL ENABLEEXTENSIONS


:version
set current_version=1.01
set version_file=tmp
echo Cheking version number...
curl --silent --output %version_file% https://raw.githubusercontent.com/danielnachumdev/SSH2HUJI/main/version
set count=0
FOR /F "tokens=1" %%x IN (%version_file%) DO (
    if %count%==0 ( rem this is to check the version if this is a bat file
        if %current_version% LSS %%x (
            echo LATEST VERSION=%%x
            echo CURRENT_VERSION=%current_version%
            echo go to https://github.com/danielnachumdev/SSH2HUJI to download the latest version
            del tmp
            goto exit
        ) else (
          echo good to go!
          del tmp
          goto start
            @REM echo You have the latest version! good to go..
        )
    )
    set %count%=%count%+1
)



:start
SET me=%~n0
@REM rem echo cd ../../course/current/<course>/presubmit/<ex>/io
@REM echo -----------------------------HOW TO USE--------------------------------------
@REM echo:                             
@REM echo if this is your first time using this then it will ask you something like this two times, say yes on both:
@REM echo:
@REM echo The authenticity of host 'bava.cs.huji.ac.il (132.65.128.9)' can't be established.
@REM echo ED25519 key fingerprint is SHA256:**************************************.
@REM echo Are you sure you want to continue connecting (yes/no/[fingerprint])?
@REM echo:
@REM echo:
@REM echo  to finish the ssh write "logout" in the terminal
@REM echo:
@REM echo ------------------------------------------------------------------------
@REM echo:
@REM echo:


:login
set /p user=[%me%] Enter CSE username:
ssh -CXJ %user%@bava.cs.huji.ac.il %user%@river
IF %ERRORLEVEL% NEQ 0 (
  echo&cls
	echo [%me%] make sure there are no other termials open and try again
	echo [%me%] if this is still a problem:
  echo [%me%] go to "C:\Users\%USERNAME%\.ssh\known_hosts"
  echo [%me%] and delete the entry about bava.cs.huji.ac.il
  set /p choise=What would you like to do? [1] try again [2] reset [3] exit: 
  goto choise
) else (
  goto exit
)


:choise
IF %choise%==1 (
    echo&cls
    goto login
)
IF %choise%==2 (
  echo:
  echo [%me%] preforming reset...
  del C:\Users\%USERNAME%\.ssh\known_hosts
  pause
  echo&cls
  goto login
)


:exit
pause