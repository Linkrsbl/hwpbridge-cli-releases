# HwpBridge CLI Quick Install

If this Windows machine already has Hangul installed, run this one-liner in PowerShell:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/bootstrap-install.ps1 | iex"
```

After install:

```powershell
hwpbridge doctor
hwpbridge auth init-config
hwpbridge auth register-protocol
hwpbridge auth login --timeout 30
hwpbridge auth whoami
hwpbridge credits balance
```

Public auth callback page:

- `https://linkrsbl.github.io/hwpbridge-cli-releases/`

Latest release:

- `https://github.com/Linkrsbl/hwpbridge-cli-releases/releases/latest`
