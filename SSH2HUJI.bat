@echo off
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
set /p username=[%me%] Enter CSE username:
ssh -CXJ %username%@bava.cs.huji.ac.il %username%@river
IF %ERRORLEVEL% NEQ 0 (
echo&cls
	echo [%me%] make sure there are no other termials open and try again
	echo [%me%] if this is still a problem:
  echo [%me%] go to "c://users/<your user>/.ssh/known_hosts"
  echo [%me%] and delete the entry about bava.cs.huji.ac.il
  pause
)
