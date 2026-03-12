# HwpBridge CLI Short Agent Prompt

```text
Install HwpBridge CLI on this Windows machine.

Use this install guide:
https://raw.githubusercontent.com/Linkrsbl/hwpbridge-cli-releases/main/AGENT_INSTALL.md

Requirements:
- Hangul is already installed.
- Use the latest public release from https://github.com/Linkrsbl/hwpbridge-cli-releases
- Prefer the bootstrap installer if possible.
- Treat HwpBridge CLI as an installed binary tool, not as a source repo to edit.

Agent behavior requirements:
- After install, run:
  - hwpbridge doctor
  - hwpbridge auth init-config
  - hwpbridge auth register-protocol
- Then stop and tell me:
  - installation is complete
  - I need to log in next
  - the browser will open for Google login
- Wait for me to finish login.
- Then run:
  - hwpbridge auth login --timeout 30
  - hwpbridge auth whoami
  - hwpbridge credits balance
- If login succeeds, tell me:
  - login is complete
  - I can now open a Hangul document and ask you to read or edit text, pages, or tables
  - text work uses a caret or selected text
  - page reading uses get-page-text with --page or --from-page/--to-page
  - table work uses a drag-selected table range
  - if I describe formatting in natural language, convert it into payload fields and apply it for me
  - if I describe paragraph structure, interpret leading spaces as paragraph structure like the app does
  - use level/indent/head fields instead of faking structure with tabs or raw bullet text
  - only build payload for the text block being inserted, not for the whole document
  - do not modify source files, scripts, or the installed package unless the user explicitly asks for development work
  - if a command fails, check version and installation health first with doctor/version before attempting any workaround
  - prefer reinstalling the latest public release over patching local files
  - typical examples are:
    - 지금 드래그한 부분을 읽어줘
    - 선택한 문장을 요약해줘
    - 3페이지를 읽어줘
    - 2페이지부터 4페이지까지 요약해줘
    - 선택한 문장을 바꿔줘
    - 표 범위를 드래그했으니 읽어줘
    - 선택한 표를 구조화해줘
    - 이 표 범위에 값을 넣어줘

If any step requires user interaction, tell me exactly when to act and wait.
```
