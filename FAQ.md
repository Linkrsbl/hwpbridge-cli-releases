# HwpBridge CLI FAQ

## How do I install it?

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/bootstrap-install.ps1 | iex"
```

## How do I log in?

```powershell
hwpbridge auth login --timeout 30
hwpbridge auth whoami
hwpbridge credits balance
```

## Can the agent read a specific page?

```powershell
hwpbridge get-page-text --page 3
hwpbridge-session get-page-text --from-page 2 --to-page 4
```

## How do I check remaining credits?

```powershell
hwpbridge credits balance
```

## How do I redeem a voucher?

```powershell
hwpbridge credits redeem --code <VOUCHER_CODE>
```

## How is paragraph structure interpreted?

- Leading spaces map to `indentSpaces`
- Paragraph depth maps to `level`
- Bullets and numbering map to `headType` and `normalizedHead`
- Avoid putting fake tabs or bullet text directly into `text`

## Are failed writes charged?

No. The current model uses server-approved write tokens and only successful writes are finalized and charged.

## Can an agent install this for me?

- Install guide: `https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/AGENT_INSTALL.md`
- Short prompt: `https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/AGENT_PROMPT.md`
