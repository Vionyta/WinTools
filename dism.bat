@echo off
setlocal EnableExtensions DisableDelayedExpansion

:: ============================================================================
:: CONFIGURATION SECTION (EDIT THESE PATHS)
:: ============================================================================
:: Path where your winre.wim is mounted
SET "MOUNT_DIR=C:\WinPE_Mount"

:: Path to your ADK 'WinPE_OCs' folder containing the .cab files
SET "ADK_PATH=C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs"

:: ============================================================================
:: PHASE 1: REMOVE INSECURE & BLOAT PACKAGES
:: ============================================================================
echo [PHASE 1] Removing insecure and legacy components...

:: Remove Scripting (VBScript) - Security Risk
dism /Image:"%MOUNT_DIR%" /Remove-Package /PackageName:WinPE-Scripting-Package~31bf3856ad364e35~amd64~~en-US~.cab /IgnoreCheck
dism /Image:"%MOUNT_DIR%" /Remove-Package /PackageName:WinPE-Scripting-Package~31bf3856ad364e35~amd64~~.cab /IgnoreCheck

:: Remove HTA (HTML Apps) - Security Risk
dism /Image:"%MOUNT_DIR%" /Remove-Package /PackageName:WinPE-HTA-Package~31bf3856ad364e35~amd64~~en-US~.cab /IgnoreCheck
dism /Image:"%MOUNT_DIR%" /Remove-Package /PackageName:WinPE-HTA-Package~31bf3856ad364e35~amd64~~.cab /IgnoreCheck

:: Remove Legacy & Bloat Tools
dism /Image:"%MOUNT_DIR%" /Remove-Package /PackageName:WinPE-MDAC-Package~31bf3856ad364e35~amd64~~.cab /IgnoreCheck
dism /Image:"%MOUNT_DIR%" /Remove-Package /PackageName:WinPE-LegacySetup-Package~31bf3856ad364e35~amd64~~.cab /IgnoreCheck
dism /Image:"%MOUNT_DIR%" /Remove-Package /PackageName:WinPE-WDS-Tools-Package~31bf3856ad364e35~amd64~~.cab /IgnoreCheck
dism /Image:"%MOUNT_DIR%" /Remove-Package /PackageName:WinPE-PPPoE-Package~31bf3856ad364e35~amd64~~.cab /IgnoreCheck
dism /Image:"%MOUNT_DIR%" /Remove-Package /PackageName:WinPE-WindowsUpdate-Package~31bf3856ad364e35~amd64~~.cab /IgnoreCheck

echo.
echo [PHASE 1] Cleanup Complete.
echo.

:: ============================================================================
:: PHASE 2: INSTALL SUPERIOR ENGINEER TOOLS (Strict Order)
:: ============================================================================
echo [PHASE 2] Installing Engineering & Security tools...

:: 1. .NET Framework (Prerequisite for PowerShell)
echo Installing .NET Framework...
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\winpe-netfx.cab"
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\en-us\winpe-netfx_en-us.cab"

:: 2. WMI (Prerequisite for SecureStartup)
echo Installing WMI...
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\winpe-wmi.cab"
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\en-us\winpe-wmi_en-us.cab"

:: 3. PowerShell (The Main Tool)
echo Installing PowerShell...
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\winpe-powershell.cab"
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\en-us\winpe-powershell_en-us.cab"

:: 4. DISM Cmdlets (PowerShell Module for Image Repair)
echo Installing DISM Cmdlets...
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\winpe-dismcmdlets.cab"
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\en-us\winpe-dismcmdlets_en-us.cab"

:: 5. Secure Startup (BitLocker Support)
echo Installing Secure Startup (BitLocker)...
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\winpe-securestartup.cab"
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\en-us\winpe-securestartup_en-us.cab"

:: 6. Enhanced Storage (Encrypted Drive Support)
echo Installing Enhanced Storage...
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\winpe-enhancedstorage.cab"
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\en-us\winpe-enhancedstorage_en-us.cab"

:: 7. Connectivity (WiFi, Dot3Svc, RNDIS)
echo Installing Connectivity...
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\winpe-wifi.cab"
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\en-us\winpe-wifi_en-us.cab"

dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\winpe-dot3svc.cab"
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\en-us\winpe-dot3svc_en-us.cab"

dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\winpe-rndis.cab"
dism /Image:"%MOUNT_DIR%" /Add-Package /PackagePath:"%ADK_PATH%\en-us\winpe-rndis_en-us.cab"

echo.
echo ==========================================================
echo  AUDIT COMPLETE.
echo  WinRE is now: SECURE, OPTIMIZED, and POWERFUL.
echo ==========================================================
pause