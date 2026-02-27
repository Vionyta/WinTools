## WSL and Sandboxing on Windows11 using Powershell 7

```Powershell
Write-Host "Starting Step 5: Deploying and Configuring WSL 2 Sandbox..." -ForegroundColor Cyan

# 1. Install WSL and the default Ubuntu distribution
Write-Host "Initiating WSL engine and Ubuntu installation..."
wsl --install -d Ubuntu

# 2. Hardening and Resource Management (.wslconfig)
Write-Host "Generating .wslconfig to enforce resource limits on the VM..."
$wslConfigPath = "$env:USERPROFILE\.wslconfig"
$wslConfigContent = @"
[wsl2]
# Limit VM to 8GB to prevent runaway processes (adjust based on your total RAM)
memory=8GB
# Limit to 4 virtual processors
processors=4
# Automatically release cached memory back to Windows
autoMemoryReclaim=dropcache
"@

Set-Content -Path $wslConfigPath -Value $wslConfigContent -Force

Write-Host "Step 5 Complete. WSL staged and resource policies applied." -ForegroundColor Green
Write-Host "CRITICAL: A system restart is now required." -ForegroundColor Yellow
```
