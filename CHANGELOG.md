# CHANGELOG.md

## [2026-03-03] — v1.2.0

### ✨ เพิ่มใหม่ (Added)

- `.claude/hooks/log-bash.sh` — PreToolUse hook บันทึกทุก Bash command พร้อม timestamp
- `.claude/settings.json` — ลงทะเบียน hook สำหรับ PreToolUse:Bash matcher

### ✏️ แก้ไข (Updated)

- `.claude/settings.local.json` — เพิ่ม chmod +x permission สำหรับ log-bash.sh

---

## [2026-03-03] — v1.1.0 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (77696bf..7a8914d)

## [2026-03-03] — v1.1.0

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-hook/SKILL.md` — skill สร้าง Claude Code hook พร้อม template + ลงทะเบียนใน settings.json

### ✏️ แก้ไข (Updated)

- `.claude/sw/SYSTEM.md` — เปลี่ยนคำเรียก user จาก "นายท่าน" เป็น "บอส"
- `skills/sw-init/SKILL.md` — อัปเดต SYSTEM.md template ให้ใช้ "บอส"

---

## [2026-03-03] — v1.0.1

### 🚀 Deploy

- `git push` สำเร็จ → `main`
- อัปเดต version `1.0.0` → `1.0.1`

### ✏️ แก้ไข (Updated)

- `.claude/sw/DEPLOY.md` — อัปเดต flow: อัปเดต version+CHANGELOG ก่อน push, ถามแค่ครั้งเดียว

## [2026-03-03] — Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `89d6b21..252200d main -> main`
- repo: https://github.com/secwind-dev/clude-plugins

### ✏️ แก้ไข (Updated)

- `.claude/sw/PROJECT.md` — เพิ่มคำอธิบาย, Tech Stack, โครงสร้างโปรเจกต์, ตาราง Skills

## [2026-03-03]

### ➕ สร้างใหม่ (Created)

- `CLAUDE.md` — สร้างครั้งแรกโดย sw-init wizard
- `CHANGELOG.md` — สร้างครั้งแรกโดย sw-init wizard
- `.claude/sw/RULE.md` — สร้างครั้งแรกโดย sw-init wizard
- `.claude/sw/SYSTEM.md` — สร้างครั้งแรกโดย sw-init wizard
- `.claude/sw/PROJECT.md` — สร้างครั้งแรกโดย sw-init wizard
- `.claude/sw/MEMORY.md` — สร้างครั้งแรกโดย sw-init wizard
- `.claude/sw/PACKAGES.md` — สร้างครั้งแรกโดย sw-init wizard
- `.claude/sw/DEPLOY.md` — สร้างครั้งแรกโดย sw-init wizard

## 🔖 กฎการบันทึก

- อ่านไฟล์นี้ก่อนเสมอ เพื่อ append ต่อ ไม่ใช่เขียนทับ
- บันทึกทุกการเปลี่ยนแปลง ไม่ว่าเล็กหรือใหญ่
- ถ้าแก้ไขหลายไฟล์ในคราวเดียว ให้รวมไว้ใต้วันที่เดียวกัน
