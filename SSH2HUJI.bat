@echo off
SETLOCAL ENABLEEXTENSIONS


:version
set current_version=1
set version_file=tmp
echo Cheking version number...
curl --output %version_file% https://raw.githubusercontent.com/danielnachumdev/SSH2HUJI/main/version



set count=0
FOR /F "tokens=1" %%x IN (%version_file%) DO (
    if %count%==0 ( rem this is to check the version if this is a bat file
        if %current_version% LSS %%x (
            echo %%x is the latest version and you have %current_version%
            goto exit
        )
        else (
          goto start
            @REM echo You have the latest version! good to go..
        )
    )
    set %count%=%count%+1
)


:start
SET me=%~n0
rem echo cd ../../course/current/<course>/presubmit/<ex>/io
echo -----------------------------HOW TO USE--------------------------------------
echo:                             
echo if this is your first time using this then it will ask you something like this two times, say yes on both:
echo:
echo The authenticity of host 'bava.cs.huji.ac.il (132.65.128.9)' can't be established.
echo ED25519 key fingerprint is SHA256:**************************************.
echo Are you sure you want to continue connecting (yes/no/[fingerprint])?
echo:
echo:
echo  to finish the ssh write "logout" in the terminal
echo:
echo ------------------------------------------------------------------------
echo:
echo:


:start
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
    goto start
)
IF %choise%==2 (
  echo:
  echo [%me%] preforming reset...
  del C:\Users\%USERNAME%\.ssh\known_hosts
  pause
  echo&cls
  goto start
)


:exit
pause