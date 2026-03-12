# HwpBridge CLI Quick Install

Windows와 한글이 이미 설치되어 있다면, PowerShell에서 아래 한 줄만 실행하면 됩니다.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/bootstrap-install.ps1 | iex"
```

설치 후:

```powershell
hwpbridge doctor
hwpbridge auth init-config
hwpbridge auth register-protocol
hwpbridge auth login --timeout 30
hwpbridge auth whoami
hwpbridge credits balance
```

릴리즈:

- `https://github.com/Linkrsbl/hwpbridge-cli-releases/releases/latest`
