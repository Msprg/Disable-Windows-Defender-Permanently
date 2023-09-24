# Disable-Windows-Defender-Permanently
There are countless tools to more or less control or disable Windows Defender antimalware real-time protection solution by Microsoft, built into the Microsoft Windows operating system by default.
These tools use a variety of methods ranging from helping users disable it by guiding them through the process via the GUI, (well documented) to employing various kinds of bypasses and fixes by altering registry entries (barely documented to outright obscure). The problem is, that Microsoft (and their software) don't respect users' settings changes, and one way or another sooner or later always gets its way.
That's why this repository exists. To end this madness and take back control and freedom.


# DISCLAIMERS
### 1. Usage of this tool (provided as-is) results in a permanent loss of antimalware protection. It's YOUR job to know what this means and how to handle it correctly. Therefore I shall not be held responsible for any issues arising from the utilization of this tool.
### 2. This tool was tested - and is recommended - to be run as soon as possible after a clean/fresh install of Windows. While in theory, it should work just fine on any recent Windows 10 and 11 installs and is technically reversible, always back up your whole system drive as a drive image to ensure 100% rollback capability.
#### 3. This tool might (and if many people start using it likely will) be identified as a malware/virus/any other kind of harmful file. After all, it was designed as such. It's just doing its job.
#### 4. YOU ARE HIGHLY ENCOURAGED to inspect the source to ensure you understand what operations will be performed on your computer, and optionally modify them to fit your specific use case, before execution.



# Usage
1. Download the script file `Defeat-Defender_ONLY.bat` and the `NSudo.exe` executable as its dependency.
2. Put them together somewhere on the target machine into a single folder (desktop is fine).
3. Open the `Defeat-Defender_ONLY.bat` in a text editor and inspect the code.
4. **I said open the `Defeat-Defender_ONLY.bat` in a text editor and inspect the code!**
5. *[Optionally]* While you're at it, modify the code - enable/disable the features you do(n't) want.
6. When ready, save the code if you've made any intentional changes,
7. Run the `Defeat-Defender_ONLY.bat` with elevation (as administrator) and fight your way through (if any) dumb prompts Microsoft throws at you (UAC, SmartScreen, etc...).
8. If it 'looked' successful (with enough experience you just know), all there is left, is to reboot the computer. Otherwise, try again.
9. After a reboot verify the defender is dead. Check Windows Security, it should have issues loading. To be extra sure verify that the original defender service is nowhere to be found and there's only a `DISABLEDWinDefend.BAK` backup instead. (see below).
10. CONGRATULATIONS! We've made it in just 10 simple steps!

# Working concept - brief overview

As was established before, methods other tools use are... not exactly 'not working', but rather ineffective. it's just that Microsoft decided to make these options just to outright ignore the living hell out of them, they can't be used anymore to disable Windows Defender 'once and for all'.

Some components of Windows Security run as system services. That includes the Windows Defender service `WinDefend`. It's hard to 'just disable' this service while keeping it, I tried. So, we just outright remove it from the system. In case it would be needed though, just before that a backup is made with the name `DISABLEDWinDefend.BAK`.

The theory is, that should a need arise to enable it, it can be done so by renaming this service in the Windows registry back to its original name `WinDefend` and rebooting the system. This, however, was never really tested on a used system. On a clean system, shortly after disabling Defender, the restoration procedure works exactly as intended, and reenables Defender successfully.

Besides this a few other steps are performed that prevent Windows from bringing Defender back from the dead. But you already know all about them because you read the source code. 

*Right?* 

***Right??***
