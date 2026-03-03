---
name: sw-create-hook
description: 'Create all default hooks (log-bash, track-action, notify-done) and register them in .claude/settings.json automatically. Usage: /sw-create-hook'
disable-model-invocation: true
---

เรียก user ว่า **บอส** เสมอ

ทำทุกอย่างอัตโนมัติ **ไม่มี AskUserQuestion** — สร้าง hooks ครบทั้งหมดในคราวเดียว

---

## ขั้นที่ 1 — สร้างโฟลเดอร์

```bash
mkdir -p .claude/hooks
```

---

## ขั้นที่ 2 — สร้าง log-bash.sh

ใช้ tool `Write` สร้างไฟล์ `.claude/hooks/log-bash.sh` ด้วยเนื้อหาต่อไปนี้:

```bash
#!/bin/bash
# Hook: log-bash
# Event: PreToolUse
# Matcher: Bash
# วัตถุประสงค์: บันทึกทุก Bash command ที่ Claude รันลงไฟล์ hook.log
#
# Input (stdin): JSON object จาก Claude Code
#   - tool_name  : ชื่อ tool (จะเป็น "Bash" เสมอเพราะ matcher ระบุไว้)
#   - tool_input : object ที่มี field "command" เป็น shell command ที่จะรัน
#
# Output:
#   - exit 0 : อนุญาตให้ Claude รัน command ต่อเสมอ

# รับ JSON input จาก stdin
INPUT=$(cat)

# ดึง command จาก tool_input.command
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# บันทึก timestamp + command ลง hook.log
echo "[$(date '+%Y-%m-%d %H:%M:%S')] $COMMAND" >> .claude/hooks/hook.log

# อนุญาตเสมอ — hook นี้เป็น logging-only ไม่บล็อก
exit 0
```

---

## ขั้นที่ 3 — สร้าง track-action.sh

ใช้ tool `Write` สร้างไฟล์ `.claude/hooks/track-action.sh` ด้วยเนื้อหาต่อไปนี้:

```bash
#!/bin/bash
# Hook: track-action
# Event: PreToolUse (ไม่มี matcher = รับทุก tool)
# วัตถุประสงค์: บันทึก context ของ action ล่าสุดไว้ใน last-action.tmp
#              เพื่อให้ notify-done.sh นำไปพูดบริบทที่ถูกต้อง
#
# Input (stdin): JSON object จาก Claude Code
#   - tool_name  : ชื่อ tool เช่น Bash, Write, Edit
#   - tool_input : input ของ tool นั้น
#
# Output:
#   - exit 0 : อนุญาตเสมอ — hook นี้เป็น tracking-only ไม่บล็อก

# รับ JSON input จาก stdin
INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

# เลือก context ตาม tool — ข้าม Read/Glob/Grep เพราะเป็น query ไม่ใช่ action
case "$TOOL" in
  Bash)
    CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
    if echo "$CMD" | grep -q 'git push'; then
      echo "push git เสร็จแล้ว" > .claude/hooks/last-action.tmp
    elif echo "$CMD" | grep -q 'git commit'; then
      echo "commit เสร็จแล้ว" > .claude/hooks/last-action.tmp
    elif echo "$CMD" | grep -q 'git'; then
      echo "รัน git เสร็จแล้ว" > .claude/hooks/last-action.tmp
    elif echo "$CMD" | grep -q 'npm\|yarn\|bun\|pnpm'; then
      echo "ติดตั้ง packages เสร็จแล้ว" > .claude/hooks/last-action.tmp
    elif echo "$CMD" | grep -q 'mkdir'; then
      echo "สร้าง folder เสร็จแล้ว" > .claude/hooks/last-action.tmp
    else
      echo "รัน command เสร็จแล้ว" > .claude/hooks/last-action.tmp
    fi
    ;;
  Write)
    # ดึงแค่ชื่อไฟล์ (ตัดเอา path ออก)
    FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' | xargs basename 2>/dev/null)
    echo "สร้างไฟล์ ${FILE} เสร็จแล้ว" > .claude/hooks/last-action.tmp
    ;;
  Edit|MultiEdit)
    FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' | xargs basename 2>/dev/null)
    echo "แก้ไขไฟล์ ${FILE} เสร็จแล้ว" > .claude/hooks/last-action.tmp
    ;;
  NotebookEdit)
    FILE=$(echo "$INPUT" | jq -r '.tool_input.notebook_path // empty' | xargs basename 2>/dev/null)
    echo "แก้ไข notebook ${FILE} เสร็จแล้ว" > .claude/hooks/last-action.tmp
    ;;
  # ข้าม Read, Glob, Grep, Task — เป็น query ไม่ใช่ action สำคัญ
  Read|Glob|Grep|Task)
    ;;
  *)
    echo "ทำงานเสร็จแล้ว" > .claude/hooks/last-action.tmp
    ;;
esac

# อนุญาตเสมอ
exit 0
```

---

## ขั้นที่ 4 — สร้าง notify-done.sh

ใช้ tool `Write` สร้างไฟล์ `.claude/hooks/notify-done.sh` ด้วยเนื้อหาต่อไปนี้:

```bash
#!/bin/bash
# Hook: notify-done
# Event: Stop
# วัตถุประสงค์: แจ้งเตือนเมื่อ Claude ทำงานเสร็จ ด้วย popup + เสียง + พูด
#              - รองรับทั้ง macOS และ Windows (Git Bash / MSYS2 / Cygwin)
#              - ดึงชื่อ Claude จาก .claude/sw/SYSTEM.md อัตโนมัติ
#              - ดึงบริบท action ล่าสุดจาก track-action.sh ผ่าน last-action.tmp
#
# Input (stdin): JSON object จาก Claude Code
#   - stop_hook_active : true ถ้า stop hook กำลัง active
#
# Output:
#   - exit 0 : ยืนยันให้หยุด

# รับ JSON input จาก stdin (ไม่ได้ใช้ในกรณีนี้ แต่ต้อง consume stdin)
INPUT=$(cat)

# ตรวจสอบ OS
OS=$(uname -s)

# ดึงชื่อจาก SYSTEM.md — รูปแบบ: "- **ชื่อ:** <ชื่อไทย> (<ชื่ออังกฤษ>)"
# fallback เป็น "Claude" ถ้าไม่พบไฟล์หรือ pattern ไม่ตรง
SYSTEM_FILE=".claude/sw/SYSTEM.md"
if [ -f "$SYSTEM_FILE" ]; then
  NAME=$(grep 'ชื่อ:' "$SYSTEM_FILE" | sed 's/.*ชื่อ:\*\* \([^ ]*\).*/\1/')
fi
NAME=${NAME:-Claude}

# อ่าน context ของ action ล่าสุดจาก track-action.sh
# ถ้าไม่มีไฟล์ → Claude แค่ตอบคำถาม ไม่ต้องเล่นเสียงและพูด
ACTION_FILE=".claude/hooks/last-action.tmp"
IS_ACTION=false
if [ -f "$ACTION_FILE" ]; then
  ACTION=$(cat "$ACTION_FILE")
  rm -f "$ACTION_FILE"
  IS_ACTION=true
fi

MSG="${NAME} ${ACTION}ค่ะ บอส!"

# แสดง popup notification (ทำทุกครั้ง)
case "$OS" in
  Darwin*)
    osascript -e "display notification \"${MSG}\" with title \"Claude Code\""
    ;;
  MINGW*|CYGWIN*|MSYS*)
    powershell.exe -NoProfile -Command "
      Add-Type -AssemblyName System.Windows.Forms
      \$n = New-Object System.Windows.Forms.NotifyIcon
      \$n.Icon = [System.Drawing.SystemIcons]::Application
      \$n.Visible = \$true
      \$n.ShowBalloonTip(3000, 'Claude Code', '${MSG}', [System.Windows.Forms.ToolTipIcon]::Info)
      Start-Sleep -Seconds 1
      \$n.Dispose()
    " &
    ;;
esac

# เล่นเสียงและพูด เฉพาะเมื่อ Claude ทำ action จริง (ไม่ใช่แค่ตอบคำถาม)
if [ "$IS_ACTION" = "true" ]; then
  case "$OS" in
    Darwin*)
      afplay /System/Library/Sounds/Funk.aiff
      say -v Kanya -r 200 "[[pbas +6]]${MSG}"
      ;;
    MINGW*|CYGWIN*|MSYS*)
      powershell.exe -NoProfile -Command "
        [System.Media.SystemSounds]::Asterisk.Play()
        Start-Sleep -Milliseconds 500
        Add-Type -AssemblyName System.Speech
        \$s = New-Object System.Speech.Synthesis.SpeechSynthesizer
        \$s.Rate = 2
        \$s.Speak('${MSG}')
      "
      ;;
  esac
fi

# ยืนยันให้ Claude หยุดทำงาน
exit 0
```

---

## ขั้นที่ 5 — ให้สิทธิ์ execute ทั้ง 3 ไฟล์

```bash
chmod +x .claude/hooks/log-bash.sh
chmod +x .claude/hooks/track-action.sh
chmod +x .claude/hooks/notify-done.sh
```

---

## ขั้นที่ 6 — ลงทะเบียนใน .claude/settings.json

อ่านไฟล์ `.claude/settings.json` ก่อน

- ถ้าไม่มีไฟล์ → สร้างใหม่
- ถ้ามีอยู่แล้ว → อ่านเนื้อหาเดิมก่อน แล้ว Write ทับโดยรวม hooks ใหม่เข้ากับ config เดิม

ใช้ tool `Write` เขียน `.claude/settings.json` ด้วย JSON นี้ (merge กับ config เดิมถ้ามี):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/track-action.sh"
          }
        ]
      },
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/log-bash.sh"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/notify-done.sh"
          }
        ]
      }
    ]
  }
}
```

> **หมายเหตุ:** ถ้าไฟล์เดิมมี keys อื่นนอกจาก `hooks` (เช่น `model`, `permissions`) ให้คงไว้และ merge เฉพาะส่วน `hooks` เข้าไป

---

## ขั้นที่ 7 — แจ้งผลสรุป

```
✅ สร้าง Default Hooks เรียบร้อยแล้วค่ะ บอส!

📄 log-bash.sh     — PreToolUse:Bash → บันทึก command ลง hook.log
📄 track-action.sh — PreToolUse:All  → track บริบท action ล่าสุดไว้ใน last-action.tmp
📄 notify-done.sh  — Stop → popup + เสียง + พูดภาษาไทยพร้อมบริบท

🔧 ลงทะเบียนใน .claude/settings.json แล้วค่ะ

💡 ทดสอบได้ด้วย:
   echo '{"tool_input":{"command":"ls"}}' | bash .claude/hooks/log-bash.sh
   echo '{"tool_name":"Bash","tool_input":{"command":"git push"}}' | bash .claude/hooks/track-action.sh
   echo '{}' | bash .claude/hooks/notify-done.sh
```
