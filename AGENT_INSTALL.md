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

## Required Agent Guidance

After install, the agent should guide the user in two stages.

### 1. Install complete -> ask the user to log in

After these commands succeed:

- `hwpbridge doctor`
- `hwpbridge auth init-config`
- `hwpbridge auth register-protocol`

the agent should stop and tell the user:

- installation is complete
- login is required before the CLI can be used
- a browser window will open for Google login

Recommended message:

- `설치가 완료됐습니다. 이제 로그인만 하면 사용할 수 있습니다. 브라우저에서 Google 로그인을 진행해 주세요.`

### 2. Login complete -> explain how to use the tool

After these commands succeed:

- `hwpbridge auth login --timeout 30`
- `hwpbridge auth whoami`
- `hwpbridge credits balance`

the agent should tell the user:

- login is complete
- they can now open a Hangul document and ask for text or table edits
- text work uses a caret position or selected text
- table work uses a drag-selected table range

Recommended message:

- `로그인이 완료됐습니다. 이제 한글 문서를 열어 두고, 원하는 문장 위치를 클릭하거나 표 범위를 드래그 선택한 뒤 저에게 수정/입력을 요청하시면 됩니다.`

Recommended first-usage hints:

- `텍스트 작업은 문서에서 커서를 두거나 문장을 선택한 뒤 요청하면 됩니다.`
- `표 작업은 필요한 표 범위만 드래그 선택한 뒤 가져오고 입력하면 됩니다.`
- `쓰기 작업은 로그인된 계정의 크레딧을 사용합니다.`

## Text Formatting Rules For Agents

When the user gives natural-language formatting instructions, the agent should
convert them into paragraph payload fields for `insert --file`.

Important paragraph fields:

- `text`: actual paragraph text
- `isBlankLine`: whether the paragraph is an empty line
- `level`: paragraph level
- `indentSpaces`: indent size
- `headType`: heading/bullet type
- `normalizedHead`: normalized bullet/number text
- `hwpStyleName`: named Hangul style if the document already uses one
- `fontName`: font family
- `fontSize`: font size
- `isBold`: bold on/off
- `letterSpacingRatio`: letter spacing / width ratio
- `lineSpacing`: line spacing

Examples of natural-language mapping:

- `제목은 맑은 고딕 12포인트 굵게`
  - `fontName: "맑은 고딕"`
  - `fontSize: 12`
  - `isBold: true`
- `본문은 10포인트, 줄간격 160`
  - `fontSize: 10`
  - `lineSpacing: 160`
- `번호 문단으로 넣어줘`
  - `headType: "numbered"`
  - `level` and `normalizedHead` as needed

If the user gives natural-language formatting instructions, the agent should
not ask for raw JSON first. It should build the payload and then run the insert
command.

## Paragraph Structure Rules For Agents

Use the same paragraph interpretation model as the app.

Important rules:

- Leading spaces define paragraph structure.
- Convert visible leading spaces into `indentSpaces`.
- Resolve `level` from the saved/template level rules for that indent width.
- Do not use raw tabs inside `text` as the primary way to express paragraph level.
- Do not fake bullets or numbering by manually stuffing marker characters into `text` unless the literal text is truly required.
- Use:
  - `headType`
  - `normalizedHead`
  - `level`
  - `indentSpaces`
  to express paragraph hierarchy.
- Keep only the paragraph body in `text`.
- Blank lines should become paragraphs with `isBlankLine: true`.

Operational rule:

- For CLI insertion, build a payload for the block being inserted now.
- Do not rebuild the whole document unless the task explicitly requires it.
- `insert` uses structured paragraph payloads.
- `replace-selection` and `replace` can stay plain-text operations.

## Requirements

- Windows
- Hangul installed
- PowerShell available
- shell-capable local agent
