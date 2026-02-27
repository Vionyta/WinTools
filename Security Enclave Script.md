## Security Enclave Script 
Windows 11 and Powershell 7

```Powershell
Write-Host "Starting Step 4: Enabling HVCI and ASR Rules..." -ForegroundColor Cyan

# 1. Enable Hypervisor-Enforced Code Integrity (Memory Integrity)
Write-Host "Enforcing Memory Integrity (HVCI)..."
$hvciPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
if (!(Test-Path $hvciPath)) { 
    New-Item -Path $hvciPath -Force | Out-Null 
}
Set-ItemProperty -Path $hvciPath -Name "Enabled" -Value 1 -Type DWord -Force
Set-ItemProperty -Path $hvciPath -Name "Locked" -Value 0 -Type DWord -Force

# 2. Configure Defender Attack Surface Reduction (ASR) Rules
# Rule 1: Block credential stealing from the Windows local security authority subsystem (LSASS)
# Rule 2: Block execution of potentially obfuscated scripts
Write-Host "Applying CIS/NIST recommended ASR Rules..."
$asrRules = @(
    "9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2", # Block LSASS credential stealing
    "5beb7efe-fd9a-4556-801d-275e5ffc04cc"  # Block obfuscated scripts
)

foreach ($rule in $asrRules) {
    Add-MpPreference -AttackSurfaceReductionRules_Ids $rule -AttackSurfaceReductionRules_Actions Enabled
}

Write-Host "Step 4 Complete. HVCI enabled and ASR rules applied." -ForegroundColor Green
Write-Host "NOTE: A system reboot is required for Memory Integrity to take full hardware effect, but we will reboot later." -ForegroundColor Yellow
```
