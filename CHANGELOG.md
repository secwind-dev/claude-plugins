# CHANGELOG.md

## [2026-03-04] — v1.5.2 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (a89ca6e..802f8e6)

---

## [2026-03-04] — v1.5.2

### ➕ เพิ่ม

- `skills/sw-init/SKILL.md` — รวม hook setup (track-action.sh + notify-done.sh + settings.json) เข้าเป็น default ขั้นที่ 3
- `skills/sw-init/SKILL.md` — แก้ `arguments:` → `argument-hint:` ให้ตรงกับ spec

### 🗑️ ลบ

- `skills/sw-create-hook/` — ยุบรวมเข้า sw-init แล้ว ไม่จำเป็นต้องมี skill แยก

---

## [2026-03-04] — v1.5.1 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (4382ab8..1be2341)

---

## [2026-03-04] — v1.5.1

### ♻️ Refactor

- `skills/sw-init/SKILL.md` — ย้าย `โทนการตอบ` ออกจาก CLAUDE.md template ไปอยู่ใน SYSTEM.md ที่เดียว (ลด redundancy)

---

## [2026-03-04] — v1.5.0 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (ad76276..34adac2)

---

## [2026-03-04] — v1.5.0

### 🐛 แก้ไข Bug (Fixed)

- `.claude-plugin/marketplace.json` — แก้ version mismatch: `1.3.4` → `1.5.0` (ทั้ง metadata และ plugins[0])
- `skills/sw-hook/SKILL.md` — แก้ persona: เปลี่ยนคำเรียก user จาก "นายท่าน" → "บอส" ทุกจุด
- `skills/sw-init/SKILL.md` — แก้ persona: เปลี่ยนคำเรียก user จาก "นายท่าน" → "บอส" ทุกจุด
- `README.md` — ลบ skills ที่ถูกลบไปแล้ว (sw-mcp-playwright, create) และเพิ่ม skills ใหม่

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-context/SKILL.md` — skill `/sw-context <library> [query]` โหลด up-to-date docs จาก Context7 เข้า context
- `skills/sw-commit/SKILL.md` — skill `/sw-commit` วิเคราะห์ git diff สร้าง Conventional Commit message พร้อม confirm
- `skills/sw-check/SKILL.md` — skill `/sw-check` ตรวจสอบ environment: runtime, git config, package manager, .env safety, .claude/ gitignore (พร้อม auto-fix)

### ✏️ แก้ไข (Updated)

- `skills/sw-postgreSQL/SKILL.md` — เพิ่ม step append `.claude/sw/POSTGRES_DB.md` เข้า `.gitignore` อัตโนมัติ
- `skills/sw-create-hook/SKILL.md` — เพิ่ม step append `.claude/hooks/last-action.tmp` เข้า `.gitignore` อัตโนมัติ
- `.claude-plugin/plugin.json` — bump version `1.4.1` → `1.5.0`

---

## [2026-03-04] — v1.4.1 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (879841d..59d6f28)

---

## [2026-03-04] — v1.4.1

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-postgreSQL/SKILL.md` — skill `/sw-postgreSQL` ตรวจสอบ/สร้าง `.claude/sw/POSTGRES_DB.md`, ถาม config ผ่าน AskUserQuestion, และ setup PostgreSQL ผ่าน Docker พร้อม decision tree ตรวจสอบ image/container

---

## [2026-03-04] — v1.4.0 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (1b744d9..56f2379)

---

## [2026-03-04] — v1.4.0

### ✨ เพิ่มใหม่ (Added)

- `.mcp.json` — เพิ่ม MCP servers ครบชุด: `playwright`, `context7`, `github`, `sequential-thinking` (auto-available เมื่อ install)

### 🗑️ ลบออก (Removed)

- `skills/sw-mcp-playwright/SKILL.md` — ลบออก เปลี่ยนไปใช้ `.mcp.json` แทน
- `skills/create/SKILL.md` — ลบออก เนื่องจากไม่ตรง use case ของ plugin

---

## [2026-03-04] — v1.3.4

### ✨ เพิ่มใหม่ (Added)

- `README.md` — อธิบายโปรเจกต์ครบถ้วน พร้อมคำสั่ง install, รายการ skills และ hooks

- `.claude-plugin/marketplace.json` — เพิ่ม marketplace config เพื่อให้ผู้ใช้ install ได้ผ่าน `/plugin marketplace add secwind-dev/clude-plugins`
- `.claude/hooks/track-action.sh` — hook script สำหรับ track บริบท action ล่าสุด
- `.claude/hooks/notify-done.sh` — hook script สำหรับแจ้งเตือนเมื่อ Claude เสร็จงาน (popup + เสียง + พูดภาษาไทย)

---

## [2026-03-03] — v1.3.4 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (0989c18..74c9561)

---

## [2026-03-03] — v1.3.4

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-mcp-playwright/SKILL.md` — skill `/sw-mcp-playwright` ติดตั้งและ config Playwright MCP server ใน ~/.claude/settings.json อัตโนมัติ (screenshot, PDF, web scraping)

---

## [2026-03-03] — v1.3.3 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (9c19f27..0989c18)

---

## [2026-03-03] — v1.3.3

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-review/SKILL.md` — skill `/sw-review` อ่าน git diff แล้วทำ code review พร้อม feedback, จุดเสี่ยง, best practice

---

## [2026-03-03] — v1.3.2

### ✏️ แก้ไข (Updated)

- `skills/sw-create-hook/SKILL.md` — ลบ hook `log-bash.sh` ออกจาก skill (ขั้นตอน, chmod, settings.json, summary)

---

## [2026-03-03] — v1.3.1

### ✏️ แก้ไข (Updated)

- `.claude/hooks/notify-done.sh` — ไม่เล่นเสียง/พูด เมื่อ Claude แค่ตอบคำถาม (ไม่มี last-action.tmp) + เปลี่ยนกลับเป็น voice Kanya ภาษาไทย
- `.claude/hooks/track-action.sh` — แก้ข้อความ echo ทั้งหมดจากภาษาอังกฤษเป็นภาษาไทย
- `.claude/hooks/notify-done.sh` — รองรับทั้ง macOS และ Windows (popup/เสียง/พูด)
- `skills/sw-create-hook/SKILL.md` — อัปเดต template notify-done.sh รองรับ cross-platform
- `skills/sw-create-hook/SKILL.md` — อัปเดต template notify-done.sh ให้ตรงกัน

---

## [2026-03-03] — v1.3.1 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (ab6bbbe..9c19f27)

---

## [2026-03-03] — v1.3.0 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (16ecc8c..ab6bbbe)

---

## [2026-03-03] — v1.3.0

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-create-hook/SKILL.md` — skill สร้าง default hooks (log-bash, track-action, notify-done) อัตโนมัติในคราวเดียว
- `.claude/hooks/track-action.sh` — PreToolUse hook (all tools) บันทึก context ของ action ล่าสุดไว้ใน last-action.tmp

### ✏️ แก้ไข (Updated)

- `.claude/hooks/notify-done.sh` — ดึงชื่อ Claude จาก SYSTEM.md + พูดบริบท action ล่าสุดจาก track-action.sh
- `.gitignore` — เพิ่ม `.test/`

---

## [2026-03-03] — v1.2.1

### ✨ เพิ่มใหม่ (Added)

- `.gitignore` — ignore `.claude/` directory ทั้งหมด

### ✏️ แก้ไข (Updated)

- untrack `.claude/` จาก git index (`git rm --cached`)

---

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
