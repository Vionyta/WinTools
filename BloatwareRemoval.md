## Windows 11, Powershell 7

```powershell
$bloatware = @(
    "Clipchamp.Clipchamp_3.0.10220.0_neutral_~_yxz26nhyzhsrt",
    "Microsoft.BingNews_2024.401.617.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.BingSearch_2022.1.43.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.BingWeather_4.54.63029.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.GamingApp_2024.401.618.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Microsoft3DViewer_2026.2602.8012.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MicrosoftOfficeHub_2026.206.1411.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MicrosoftSolitaireCollection_4.25.1130.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MixedReality.Portal_2000.21051.1282.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.People_2021.2202.100.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.SkypeApp_15.150.3125.0_neutral_~_kzf8qxf38zg5c",
    "Microsoft.WindowsFeedbackHub_2025.1216.1830.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WindowsMaps_2022.2506.3.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Xbox.TCUI_1.24.10001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxApp_48.104.4001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxGameOverlay_1.54.4001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxGamingOverlay_7.325.11061.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxIdentityProvider_12.130.16001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxSpeechToTextOverlay_2024.401.618.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.YourPhone_1.25072.79.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.ZuneMusic_11.2512.10.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.ZuneVideo_2019.25121.10051.0_neutral_~_8wekyb3d8bbwe"
)

foreach ($app in $bloatware) {
    Write-Host "Removing $app..." -ForegroundColor Cyan
    dism.exe /Online /Remove-ProvisionedAppxPackage /PackageName:$app
}
Write-Host "Bloatware removal complete." -ForegroundColor Green
```
