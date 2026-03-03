#!/bin/bash
# Hook: log-bash
# Event: PreToolUse
# Matcher: Bash
# วัตถุประสงค์: บันทึกทุกคำสั่ง Bash ที่ Claude รัน ลงไฟล์ .claude/hooks/hook.log
#
# Input (stdin): JSON object จาก Claude Code
#   - tool_name  : ชื่อ tool ที่ถูกใช้ (จะเป็น "Bash" เสมอ เพราะ matcher)
#   - tool_input : object ที่มี .command = คำสั่งที่จะรัน
#
# Output:
#   - exit 0     : อนุญาตให้ Claude รันคำสั่งต่อ
#   - exit 2     : บล็อกคำสั่ง + ส่ง stderr กลับให้ Claude

# รับ JSON input จาก stdin
INPUT=$(cat)

# ดึงคำสั่งจาก tool_input.command
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# บันทึกลง log พร้อม timestamp
LOG_FILE="$(dirname "$0")/hook.log"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] $ $COMMAND" >> "$LOG_FILE"

# exit 0 = อนุญาตให้ Claude ทำงานต่อ
exit 0
