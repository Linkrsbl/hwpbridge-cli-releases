# hwpbridge-cli-releases

Release artifacts for `HwpBridge CLI`.

## Install

Latest release:

- releases: `https://github.com/Linkrsbl/hwpbridge-cli-releases/releases/latest`
- direct bootstrap script: `https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/bootstrap-install.ps1`
- agent install guide: `https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/AGENT_INSTALL.md`
- quick install note: `https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/INSTALL.md`
- short agent prompt: `https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/AGENT_PROMPT.md`

Preferred one-step install:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/bootstrap-install.ps1 | iex"
```

## Auth Callback Page

This release repo also hosts the public OAuth callback page used by `HwpBridge CLI`.

- Pages URL: `https://linkrsbl.github.io/hwpbridge-cli-releases/`

That URL should be allowlisted in Supabase Redirect URLs before the source repo
is made private.
