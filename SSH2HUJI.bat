@echo off
echo VERSION_NUMBER=0.9.5
SETLOCAL ENABLEEXTENSIONS
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
  echo [%me%] preforming reset...
  del C:\Users\%USERNAME%\.ssh\known_hosts
  pause
  echo&cls
  goto start
)


:exit
pause