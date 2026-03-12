param(
    [string]$InstallRoot = "$env:LOCALAPPDATA\Programs\HwpBridgeCli",
    [switch]$SkipProtocolRegistration,
    [switch]$SkipPathUpdate
)

$ErrorActionPreference = 'Stop'

$owner = 'Linkrsbl'
$repo = 'hwpbridge-cli-releases'
$apiUrl = "https://api.github.com/repos/$owner/$repo/releases/latest"
$userAgent = 'hwpbridge-cli-bootstrap'

$tempRoot = Join-Path $env:TEMP 'hwpbridge-cli-bootstrap'
$downloadPath = Join-Path $tempRoot 'hwpbridge-cli-latest.zip'
$extractRoot = Join-Path $tempRoot 'package'

if (Test-Path $tempRoot) {
    Remove-Item $tempRoot -Recurse -Force
}

New-Item -ItemType Directory -Path $tempRoot -Force | Out-Null

$release = Invoke-RestMethod -Uri $apiUrl -Headers @{
    Accept = 'application/vnd.github+json'
    'User-Agent' = $userAgent
}

$asset = @($release.assets | Where-Object { $_.name -like 'hwpbridge-cli-*-win-x64.zip' } | Select-Object -First 1)
if (-not $asset) {
    throw 'Could not find a win-x64 zip asset in the latest release.'
}

Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $downloadPath -Headers @{
    'User-Agent' = $userAgent
}

Expand-Archive -Path $downloadPath -DestinationPath $extractRoot -Force

$installScript = Join-Path $extractRoot 'install.ps1'
if (-not (Test-Path $installScript)) {
    throw "install.ps1 not found in extracted package: $installScript"
}

$installArgs = @(
    '-NoProfile',
    '-ExecutionPolicy', 'Bypass',
    '-File', $installScript,
    '-InstallRoot', $InstallRoot
)

if ($SkipProtocolRegistration) {
    $installArgs += '-SkipProtocolRegistration'
}
if ($SkipPathUpdate) {
    $installArgs += '-SkipPathUpdate'
}

& powershell @installArgs | Out-Host

@{
    success = $true
    message = 'bootstrap install completed'
    payload = @{
        installRoot = $InstallRoot
        downloadedAsset = $asset.name
        downloadedFrom = $asset.browser_download_url
        releaseTag = $release.tag_name
    }
} | ConvertTo-Json -Depth 10
