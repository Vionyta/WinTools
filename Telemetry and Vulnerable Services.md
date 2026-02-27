## Windows 11, Powershell 7

```Powershell
Write-Host "Starting Step 3: Disabling Telemetry and Hardening Services..." -ForegroundColor Cyan

# 1. Disable Connected User Experiences and Telemetry (DiagTrack)
Write-Host "Disabling DiagTrack Service..."
Stop-Service -Name "DiagTrack" -WarningAction SilentlyContinue
Set-Service -Name "DiagTrack" -StartupType Disabled

# 2. Disable WAP Push Message Routing Service (Diagnostic data routing)
Write-Host "Disabling dmwappushservice..."
Stop-Service -Name "dmwappushservice" -WarningAction SilentlyContinue
Set-Service -Name "dmwappushservice" -StartupType Disabled

# 3. Disable Remote Registry (Major security risk, allows remote registry modification)
Write-Host "Disabling Remote Registry..."
Stop-Service -Name "RemoteRegistry" -WarningAction SilentlyContinue
Set-Service -Name "RemoteRegistry" -StartupType Disabled

# 4. Enforce Telemetry Restriction via Registry (Equivalent to Group Policy)
Write-Host "Applying Registry Policies for Data Collection..."
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
if (!(Test-Path $registryPath)) { 
    New-Item -Path $registryPath -Force | Out-Null 
}
Set-ItemProperty -Path $registryPath -Name "AllowTelemetry" -Value 0 -Type DWord -Force

Write-Host "Step 3 Complete. Telemetry restricted and vulnerable services disabled." -ForegroundColor Green
```
