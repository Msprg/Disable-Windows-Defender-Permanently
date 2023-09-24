@echo off


echo

title Defeat defender: originally by swagkarna, modified by Msprg 
:: BatchGotAdmin
::-----------------------------------------
REM  --> CheckING for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
echo msgbox "Please Wait While we install necessary packages for You!.Window will be closed after Installation!!!" > %tmp%\tmp.vbs
REM wscript %tmp%\tmp.vbs
del %tmp%\tmp.vbs

echo  Gathering dependencies...

color 0a

copy %~dp0\NSudo.exe %temp%\NSudo.exe

cd  %temp%

REM bitsadmin/transfer Explorers /download /priority FOREGROUND https://raw.githubusercontent.com/swagkarna/Bypass-Tamper-Protection/main/NSudo.exe %temp%\NSudo.exe

set pop=%systemroot%

echo  This is last chance to abort before Diabling Windows Defender permanently! Close window or 2x control-c to abort.
pause
echo  Permanently disabling Windows Defender NOW!

REM cripples SmartAssScreen
NSudo -U:T -ShowWindowMode:Hide icacls "%pop%\System32\smartscreen.exe" /inheritance:r /remove *S-1-5-32-544 *S-1-5-11 *S-1-5-32-545 *S-1-5-18

REM NSudo -U:T -ShowWindowMode:Hide reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System"  /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f

REM Disables annoying notifications about Defender being non-functional.
NSudo -U:T -ShowWindowMode:Hide reg add "HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration"  /v "Notification_Suppress" /t REG_DWORD /d "1" /f
 

REM NSudo -U:T -ShowWindowMode:Hide reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRun" /t REG_DWORD /d "1" /f



REM Stop, disable, backup and REMOVE the 'windefend' service.
NSudo -U:T -ShowWindowMode:Hide  sc stop  windefend  

NSudo -U:T -ShowWindowMode:Hide  sc config  windefend  start= disabled  


NSudo -U:T -ShowWindowMode:Hide reg copy "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" "HKLM\SYSTEM\CurrentControlSet\Services\DISABLEDWinDefend.BAK" /s /f



NSudo -U:T -ShowWindowMode:Hide  sc delete  windefend  






REM ignore bat files
REM powershell.exe -command "Add-MpPreference -ExclusionExtension ".bat""

REM Disables 'Startup repair' - as it may reintroduce the defender back. My experience is, it's safe to turn it back on some time later. 
NSudo -U:T -ShowWindowMode:Hide bcdedit /set {default} recoveryenabled No

REM boot even trough non-fatal failures and security violations.
REM NSudo -U:T -ShowWindowMode:Hide bcdedit /set {default} bootstatuspolicy ignoreallfailures

REM powershell -inputformat none -outputformat none -NonInteractive -Command "Add-MpPreference -ExclusionPath '"%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup'"

REM powershell.exe New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force

REM Disables/changes some other Windows Security/Defender related settings.
powershell.exe -command "Set-MpPreference -EnableControlledFolderAccess Disabled"

powershell.exe -command "Set-MpPreference -PUAProtection disable"

powershell.exe -command "Set-MpPreference -HighThreatDefaultAction 6 -Force"
powershell.exe -command "Set-MpPreference -ModerateThreatDefaultAction 6"
      
powershell.exe -command "Set-MpPreference -LowThreatDefaultAction 6"

powershell.exe -command "Set-MpPreference -SevereThreatDefaultAction 6"

powershell.exe -command "Set-MpPreference -ScanScheduleDay 8"

REM Disables firewall - DO NOT ENABLE YOU ALMOST NEVER WANT TO BE WITHOUT FIREWALL!
REM powershell.exe -command "netsh advfirewall set allprofiles state off"

echo If all looks good, you can reboot now.
pause >nul