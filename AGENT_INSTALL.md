# HwpBridge CLI Agent Install

Use this document when a shell-capable local agent should install `HwpBridge CLI`
for the user.

## Public Release Inputs

- release repo: `https://github.com/Linkrsbl/hwpbridge-cli-releases`
- latest release page: `https://github.com/Linkrsbl/hwpbridge-cli-releases/releases/latest`
- latest release API: `https://api.github.com/repos/Linkrsbl/hwpbridge-cli-releases/releases/latest`
- bootstrap script: `https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/bootstrap-install.ps1`
- hosted auth callback page: `https://linkrsbl.github.io/hwpbridge-cli-releases/`

## Auth Redirect Setup

Supabase Redirect URLs should allowlist:

- `https://linkrsbl.github.io/hwpbridge-cli-releases/`

## Preferred Install Command

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/bootstrap-install.ps1 | iex"
```

If `Invoke-Expression` is blocked:

```powershell
$tmp = Join-Path $env:TEMP 'hwpbridge-bootstrap.ps1'
Invoke-WebRequest https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/bootstrap-install.ps1 -OutFile $tmp
powershell -NoProfile -ExecutionPolicy Bypass -File $tmp
```

## Verify Install

```powershell
hwpbridge doctor
hwpbridge auth init-config
hwpbridge auth register-protocol
hwpbridge auth login --timeout 30
hwpbridge auth whoami
hwpbridge credits balance
```

## Requirements

- Windows
- Hangul installed
- PowerShell available
- shell-capable local agent
