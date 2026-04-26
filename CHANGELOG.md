# CHANGELOG.md

## [2026-04-26] — v1.10.2

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-explore/SKILL.md` — สร้าง skill ใหม่ `/sw-explore [topic]` สำหรับสำรวจ topic ซับซ้อนผ่านการถามตอบ interactive:
    - ตรวจ session เก่าอัตโนมัติ — เลือกต่อหรือเริ่มใหม่ได้
    - Aiko ออกความเห็นหลังทุกคำตอบ การตัดสินใจเป็นของ user เสมอ
    - Auto-save ลง `.claude/sw/awaken/<topic>-explore.md` ทุกครั้ง

### 🔧 แก้ไข (Changed)

- `DOCS.md` — เพิ่ม `/sw-explore` entry
- `README.md` — เพิ่ม sw-explore ใน skill table

---

## [2026-04-26] — v1.10.1

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-deploy/SKILL.md` — สร้าง skill ใหม่ `/sw-deploy` แทน Special Command `sw-deploy`

### 🔧 แก้ไข (Changed)

- `CLAUDE.md` + `skills/sw-init/templates/CLAUDE.md` — ลบ section "⚡ Special Commands" (sw-deploy ย้ายไปเป็น skill แล้ว)
- `DOCS.md` — เพิ่ม `/sw-deploy` ในรายการ skills
- `README.md` — เพิ่ม sw-deploy ใน skill table

---

## [2026-04-26] — v1.10.0 🚀 Deploy

### 🚀 Deploy

- pushed to `main` (7ca5023..d7ac5eb)

---

## [2026-04-26] — v1.10.0

### ✨ เพิ่มใหม่ (Added)

- `CLAUDE.md` + `skills/sw-init/templates/CLAUDE.md` — เพิ่ม section "🧠 วิธีคิดก่อน Code" (Think Before Coding + Goal-Driven Execution) จาก Andrej Karpathy's principles

### 🔧 แก้ไข (Changed)

- `skills/sw-init/templates/SYSTEM.md` → `skills/sw-init/templates/SOUL.md` — เปลี่ยนชื่อ template
- `skills/sw-init/SKILL.md` — แก้ template source path: `templates/SYSTEM.md` → `templates/SOUL.md`
- `skills/sw-awaken/SKILL.md`, `sw-check/SKILL.md`, `sw-commit/SKILL.md`, `sw-init/SKILL.md` — เปลี่ยนชื่อ default จาก "อิงโกะ (Inko)" → "ไอโกะ (Aiko)"
- `skills/sw-init/templates/SOUL.md` — เปลี่ยนชื่อ default character เป็น "ไอโกะ (Aiko)"

---

## [2026-04-19]

### ✏️ เปลี่ยนชื่อ (Renamed)

- `.claude/sw/SYSTEM.md` → `.claude/sw/SOUL.md` — เปลี่ยนชื่อไฟล์ตัวตน/บุคลิกภาพ
- `skills/sw-init/templates/SYSTEM.md` → `skills/sw-init/templates/SOUL.md` — อัปเดต template ตาม

### 🔧 แก้ไข (Changed)

- `CLAUDE.md` — อัปเดต Startup Sequence ข้อ 2: `SYSTEM.md` → `SOUL.md`
- `DOCS.md` — อัปเดต reference `SYSTEM.md` → `SOUL.md` (2 จุด)
- `README.md` — อัปเดต description ใน sw-init table
- `skills/sw-init/SKILL.md` — อัปเดตทุก reference (description + ขั้นที่ 2 + checklist)
- `skills/sw-init/templates/CLAUDE.md` — อัปเดต Startup Sequence ข้อ 2
- `skills/sw-init/templates/CHANGELOG.md` — อัปเดต entry สร้างไฟล์
- `skills/sw-init/templates/SOUL.md` — อัปเดต header `# SYSTEM.md` → `# SOUL.md`
- `skills/sw-init/templates/hooks/notify-done.sh` — อัปเดต path `SYSTEM.md` → `SOUL.md`

---

## [2026-03-10] — v1.9.1 🚀 Deploy

### 🚀 Deploy

- pushed to `main` (fc94747..01798ba)

---

## [2026-03-10] — v1.9.1

### 🔧 แก้ไข (Changed)

- `DOCS.md` — อัปเดตครั้งใหญ่:
    - ลบ `PACKAGES.md` ออกจากรายการ sw-init
    - อัปเดต sw-review — เพิ่มคำอธิบาย confidence level, Breaking Changes, CLAUDE.md Compliance
    - อัปเดต sw-adc — เขียนใหม่ให้ตรงกับ behavior ปัจจุบัน (สร้าง function + แนะนำต่อยอด)
    - เพิ่ม skill ที่ขาดหายไป 5 รายการ: sw-adc, sw-refactor-code, sw-generate, sw-yt, sw-version

---

## [2026-03-10] — v1.9.0

### 🔧 แก้ไข (Changed)

- `skills/sw-adc/SKILL.md` — เขียนใหม่ให้ชัดเจนขึ้น:
    - ตัด mode "แปลง code" ออก เหลือแค่ mode "สร้าง function จากคำสั่ง" อย่างเดียว
    - เพิ่มขั้นที่ 4 — แนะนำ 3 function ต่อยอดหลังสร้างเสร็จ
    - ปรับ argument-hint และ description ให้ตรงกับ behavior ใหม่

---

## [2026-03-10] — v1.8.9

### 🔧 แก้ไข (Changed)

- `skills/sw-init/SKILL.md` — ลบทุกส่วนที่เกี่ยวกับการสร้าง `.claude/sw/PACKAGES.md` ออก (frontmatter description, section สร้างไฟล์, และ summary รายการไฟล์)

---

## [2026-03-10] — v1.8.8

### 🔧 แก้ไข (Changed)

- `skills/sw-review/SKILL.md` — ปรับปรุงคุณภาพ review จากการศึกษา code-review (Anthropic Official):
    - เพิ่มการอ่าน `CLAUDE.md` ก่อน review เพื่อตรวจ convention ของโปรเจกต์
    - เพิ่ม `git log` ของไฟล์ที่เปลี่ยนเพื่อ detect pre-existing issues
    - เพิ่ม confidence level (`🔴 HIGH` / `🟡 MED` / `⚪ LOW`) ต่อ issue
    - เพิ่ม section **Breaking Changes** ตรวจ function signature / interface / export
    - เพิ่ม section **CLAUDE.md Compliance** (แสดงเฉพาะเมื่อพบไฟล์)
    - แก้ logic `git diff` ให้ถูกต้อง — fallback ใช้ `--cached` เฉพาะ repo ใหม่ที่ไม่มี HEAD
    - เพิ่ม `git diff --stat` สำหรับภาพรวมก่อนวิเคราะห์
    - สรุปตาราง: เพิ่มแถว Breaking Changes และ CLAUDE.md, เปลี่ยน "ควร merge?" → "ควร commit?"

---

## [2026-03-09] — v1.8.7 🚀 Deploy

### 🚀 Deploy

- pushed to `main` (185ae3e..3933128)

---

## [2026-03-09] — v1.8.7

### 🔧 แก้ไข (Changed)

- `skills/sw-doctor/SKILL.md` — แก้ bug การอ่าน version จาก cache สุ่ม → อ่านจาก `installed_plugins.json` โดยตรง พร้อม scope-aware selection (user scope ก่อน)

---

## [2026-03-09] — v1.8.6 🚀 Deploy

### 🚀 Deploy

- pushed to `main` (c36efc6..bdb31b1)

---

## [2026-03-09] — v1.8.6

### 🔧 แก้ไข (Changed)

- `skills/sw-version/SKILL.md` — แก้ bug การอ่าน version จาก cache สุ่ม → อ่านจาก `installed_plugins.json` โดยตรง พร้อม scope-aware selection (user scope ก่อน)

---

## [2026-03-08] — v1.8.5 🚀 Deploy

### 🚀 Deploy

- pushed to `main` (0eacb78..4a2589e)

---

## [2026-03-08] — v1.8.5

### 🔧 แก้ไข (Changed)

- `skills/sw-init/templates/CLAUDE.md` — ลบ Context Loading Tiers section (sync กับ CLAUDE.md หลัก)

---

## [2026-03-08] — v1.8.4 🚀 Deploy

### 🚀 Deploy

- pushed to `main` (589718a..81fdc68)

---

## [2026-03-08] — v1.8.4

### 🔧 แก้ไข (Changed)

- `CLAUDE.md` + `skills/sw-init/templates/CLAUDE.md` — ลบ Context Loading Tiers section (ซ้ำกับ Startup Sequence และ Routing Table) + เพิ่มความชัดเจน Startup Sequence warning

---

## [2026-03-08] — v1.8.3 🚀 Deploy

### 🚀 Deploy

- pushed to `main` (908be31..73efaaa)

---

## [2026-03-08] — v1.8.3

### 🔧 แก้ไข (Changed)

- `CLAUDE.md` + `skills/sw-init/templates/CLAUDE.md` — ย้าย Awaken loading เข้า Startup Sequence เป็น Tier 1 Mandatory (ขั้นที่ 3) แทนการอ่านผ่าน SYSTEM.md
- `skills/sw-init/templates/SYSTEM.md` — ลบ `## 🌅 Awaken Knowledge` section ออก (ไม่ duplicate กับ CLAUDE.md แล้ว); แก้ `\*\*` markdown ที่ escape ผิด
- `skills/sw-awaken/SKILL.md` — refactor ให้รับ argument บังคับ (`url|path`) เท่านั้น ลบ no-argument folder scan flow ออก
- `.gitignore` — เปิดให้ `CLAUDE.md` ถูก track โดย git

---

## [2026-03-08]

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-init/templates/CLAUDE.md` — template สำหรับ sw-init (แยกออกจาก SKILL.md)
- `skills/sw-init/templates/RULE.md` — template สำหรับ sw-init
- `skills/sw-init/templates/SYSTEM.md` — template สำหรับ sw-init
- `skills/sw-init/templates/PROJECT.md` — template สำหรับ sw-init
- `skills/sw-init/templates/MEMORY.md` — template สำหรับ sw-init
- `skills/sw-init/templates/PACKAGES.md` — template สำหรับ sw-init
- `skills/sw-init/templates/CHANGELOG.md` — template สำหรับ sw-init
- `skills/sw-init/templates/DEPLOY.md` — template สำหรับ sw-init
- `skills/sw-init/templates/settings.json` — template สำหรับ sw-init
- `skills/sw-init/templates/hooks/track-action.sh` — template สำหรับ sw-init
- `skills/sw-init/templates/hooks/notify-done.sh` — template สำหรับ sw-init

### 🔧 แก้ไข (Changed)

- `CLAUDE.md` — เพิ่ม section `🔄 Context Loading Tiers` อธิบาย 4 ระดับการโหลด context
- `skills/sw-init/templates/CLAUDE.md` — เพิ่ม Context Loading Tiers section ใน template ด้วย
- `CLAUDE.md` + `skills/sw-init/templates/CLAUDE.md` — แก้ Tier 4 Awaken: โหลดทุก session ผ่าน SYSTEM.md (ไม่ใช่แค่ครั้งแรก); ลบ `sw-status` ออกจาก Special Commands
- `skills/sw-init/SKILL.md` — refactor แทนที่ embedded template blocks ด้วย reference ไปยัง `skills/sw-init/templates/` ลด duplication และง่ายต่อการบำรุงรักษา; เพิ่มสร้าง `.claude/sw/awaken/` และ `.claude/sw/session/` เป็น default; แก้ template path ให้ใช้ `<Base directory for this skill>/templates/` แทน path relative

---

## [2026-03-08] — v1.8.2 🚀 Deploy

### 🚀 Deploy

- pushed to `main` (2506f5a..7ba08c2)

---

## [2026-03-08] — v1.8.2

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-yt/SKILL.md` — สร้าง skill ใหม่ `/sw-yt <url> [--create=<folder>]` สรุปเนื้อหา YouTube video โดยใช้ yt-dlp ดึง subtitle (th/en) แล้วสรุปเป็นภาษาไทย พร้อมแสดง title, channel, duration และ bullet points หลัก; ถ้ามี `--create=<folder>` จะบันทึกไฟล์ `.md` ไปยัง folder ที่ระบุอัตโนมัติ; merge title/channel/duration เข้ากับขั้น subtitle ด้วย `--print` flag เพื่อลด API call; เปลี่ยน `ls` เป็น `find` สำหรับ glob ที่ปลอดภัยกว่า

---

## [2026-03-07] — v1.8.1

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-version/SKILL.md` — สร้าง skill ใหม่สำหรับเช็ค version ของ sw-claude-plugins

### 🔧 แก้ไข (Changed)

- `skills/sw-on-session/SKILL.md` — เพิ่มคำสั่ง `--create` สำหรับ path/URL: ทำความเข้าใจ content และบันทึกไฟล์ไว้ใน `.claude/sw/session/` พร้อมกัน

---

## [2026-03-06] — v1.8.1 🚀 Deploy

### 🚀 Deploy

- pushed to `main` (f35ad6c..37ba6e7)

---

## [2026-03-06] — v1.8.1

### 📝 เอกสาร (Docs)

- `README.md` — เพิ่ม Vision statement และ skills `sw-awaken`, `sw-on-session` ในตาราง

---

## [2026-03-06] — v1.8.0 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (474495d..a4cacec)

---

## [2026-03-06] — v1.8.0

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-awaken/SKILL.md` — สร้าง skill ใหม่ `/sw-awaken` สำหรับเพิ่มความรู้ถาวรให้ไอโกะจากไฟล์ใน `.claude/sw/awaken/` หรือจาก URL (auto-load ทุก session)
- `skills/sw-on-session/SKILL.md` — สร้าง skill ใหม่ `/sw-on-session` สำหรับโหลด session context จากไฟล์ใน `.claude/sw/session/` หรือจาก URL
- `DOCS.md` — เพิ่มเอกสาร skill `sw-awaken` และ `sw-on-session`

### ✏️ แก้ไข (Changed)

- `.claude/sw/SYSTEM.md` — เพิ่ม `## 🌅 Awaken Knowledge` directive เพื่อ auto-load ไฟล์ใน `.claude/sw/awaken/` ทุก session

---

## [2026-03-05] — v1.7.0 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (ab90376..657a6e7)

---

## [2026-03-05] — v1.7.0

### ✨ เพิ่มใหม่ / แก้ไข (Added / Changed)

- `skills/sw-init/SKILL.md` — เพิ่ม rule ให้ไอโกะถาม user ก่อนเมื่อเห็นคำสั่งผิดหรือเสี่ยงต่อความเสียหายของโปรเจกต์
- `skills/sw-adc/SKILL.md` — แก้ example timestamp จาก hardcode เป็น `YYYY-MM-DD HH:MM:SS` พร้อมระบุให้ใช้วันที่จริง ณ ตอนที่สร้าง

---

## [2026-03-05] — v1.6.9 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (a9e105a..79bbbe3)

---

## [2026-03-05] — v1.6.9

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-generate/SKILL.md` — skill ใหม่สำหรับสร้างไฟล์จาก response ล่าสุดในการสนทนา
    - **Code file** (`.ts`, `.js`, `.py`, ฯลฯ) → ดึงเฉพาะ code block ที่สมบูรณ์ที่สุด (priority: `✅ summary section` → code block สุดท้าย)
    - **Text/Doc file** (`.md`, `.txt`, `.json`, ฯลฯ) → เขียน content ทั้งหมดของ response ลงไฟล์

---

## [2026-03-05] — v1.6.8 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (76c8d7e..3d6d7d4)

---

## [2026-03-05] — v1.6.8

### 🐛 แก้ไข Bug (Fixed)

- `skills/sw-init/SKILL.md` — แก้ markdown fence mismatch ใน DEPLOY.md template (inner `bash` block ใช้ ` ` ``` แทน ` `` `)

---

## [2026-03-05] — sw-adc

### ✏️ แก้ไข (Changed)

- `skills/sw-adc/SKILL.md` — ปรับ Argument รับได้ทั้ง code และคำสั่งภาษาไทย/อังกฤษ, ขั้นที่ 1 auto-fetch ADC.md จาก GitHub ถ้าไม่มี local file
    - เพิ่มระบบตรวจสอบโหมด: **แปลง code** vs **สร้าง code**
    - เพิ่มขั้นที่ 2G (วิเคราะห์คำสั่ง) และ 3G (สร้าง code ใน ADC style)
    - เพิ่ม format header `✨ ADC Style Generation` สำหรับโหมดสร้าง
    - อัปเดต `description`, `argument-hint`, และ usage examples

---

## [2026-03-05] — v1.6.7 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (bdcccbc..481c1c7)

---

## [2026-03-05] — v1.6.7

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-refactor-code/SKILL.md` — skill ใหม่สำหรับ refactor code ตาม rule ใน `.claude/sw/REFACTOR.md`
    - รับ `path` (required) และ `query` (optional)
    - สร้าง `.claude/sw/REFACTOR.md` อัตโนมัติถ้ายังไม่มี พร้อม rule Functional Programming ครบชุด
    - เน้น pure function, immutability, function composition — ไม่ใช้ OOP
    - user ปรับแต่ง rule ได้เองในภายหลัง

---

## [2026-03-05] — v1.6.6 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (221ecd5..2bf1e7b)

---

## [2026-03-05] — v1.6.6

### 🗑️ ลบออก (Removed)

- `skills/sw-task/SKILL.md` — ลบ skill sw-task ออกจากโปรเจกต์
- `DOCS.md` — ลบ section `/sw-task` ออก

---

## [2026-03-05] — v1.6.5

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-audit/SKILL.md` — skill ใหม่: Security audit แบบ comprehensive — ตรวจ OWASP Top 10 patterns, hardcoded secrets, dependency vulnerabilities (npm audit / pip-audit), config safety พร้อม Risk Score (0-100) และ findings จัดกลุ่ม Critical/High/Medium/Low
- `DOCS.md` — เพิ่ม `/sw-audit`, `/sw-secret`, `/sw-task` ที่ขาดไป

### ✏️ แก้ไข (Updated)

- `skills/sw-audit/SKILL.md` — ลบ flags `--deps` / `--code` ออก ทำให้ใช้งานง่ายขึ้น, รวม bash commands ให้น้อยลงเพื่อประหยัด context, เปลี่ยน `npm audit --json` → text output, เพิ่มคำแนะนำ clear session หลัง audit เสร็จ
- `DOCS.md` — อัปเดต description ของ `/sw-audit` ให้ตรงกับ spec ใหม่

---

## [2026-03-05] — v1.6.4

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-task/SKILL.md` — skill ใหม่: จัดการ session tasks — แตก goal เป็น steps, track progress, mark done พร้อม modes: plan/list/add/done/clear

---

## [2026-03-05] — v1.6.3

### ✨ เพิ่มใหม่ (Added)

- `skills/sw-secret/SKILL.md` — skill ใหม่: สแกนหา hardcoded secrets, API keys, credentials ใน codebase พร้อม severity levels (Critical/Warning/Info) และตรวจ .gitignore coverage

---

## [2026-03-05] — v1.6.2 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (0f72793..f78211f)

---

## [2026-03-05] — v1.6.2

### ✏️ แก้ไข (Updated)

- `skills/sw-init/SKILL.md` — ลบ `sw-init` และ `sw-reload` ออกจาก Special Commands table เหลือเฉพาะ `sw-status` และ `sw-deploy`
- `CLAUDE.md` — sync Special Commands table ให้ตรงกับ SKILL.md

---

## [2026-03-05] — v1.6.1 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (8845d5e..06c98cd)

---

## [2026-03-05] — v1.6.1

### ✏️ แก้ไข (Updated)

- `DOCS.md` — ตัด section ที่ไม่เกี่ยวข้องออก เหลือเฉพาะ Skills ทั้งหมด

---

## [2026-03-05] — v1.6.0 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (718ed47..0829bd4)

---

## [2026-03-05] — v1.6.0

### ➕ สร้างใหม่ (Created)

- `DOCS.md` — คู่มือการใช้งาน skills ทั้งหมด เป็น single source of truth บน GitHub

### ✏️ แก้ไข (Updated)

- `.claude/sw/DEPLOY.md` — เพิ่ม `DOCS.md` ใน deploy checklist ป้องกัน version drift
- `README.md` — เพิ่ม `DOCS.md` ในตารางไฟล์ที่ต้องอัปเดตตอน deploy
- `skills/sw-docs/SKILL.md` — skill ดึง DOCS.md จาก GitHub มาแสดงสดทุกครั้ง
- `skills/sw-doctor/SKILL.md` — skill ตรวจสอบ version เทียบ GitHub, แสดง changelog ของ version ใหม่ พร้อมคำสั่ง update ให้ user รันเอง รองรับ installed mode และ dev mode

---

## [2026-03-05] — v1.5.5 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (3eea6eb..8dd7015)

---

## [2026-03-05] — v1.5.5

### ✏️ แก้ไข (Updated)

- `skills/sw-postgreSQL/SKILL.md` — เปลี่ยนจาก `docker run` เป็น `docker-compose.yml` + `.env` (credentials แยกใน .env ที่ gitignored), เพิ่มคำเตือน production, ลบ dead reference `.claude/sw/POSTGRES_DB.md`

### ➕ สร้างใหม่ (Created)

- `.claude/agents/secwind.md` — SecWind agent มี 3 ความสามารถ: ตัดสินใจเทคนิค, เขียนโค้ดสไตล์บอส, review & approve

---

## [2026-03-05] — v1.5.4 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (6d493a8..dee790d)

---

## [2026-03-05] — v1.5.4

### 🐛 แก้ไข (Fixed)

- `skills/sw-init/SKILL.md` — inject `$ARGUMENTS` เพื่อให้ Claude รับ project name ได้จริง (bug fix)
- `.gitignore` — เพิ่ม `.claude/hooks/last-action.tmp`

---

## [2026-03-04] — v1.5.3 🚀 Deploy

### 🚀 Deploy

- `git push` สำเร็จ → `main` (94b938a..a707ef0)

---

## [2026-03-04] — v1.5.3

### ✏️ แก้ไข

- `README.md` — ลบ sw-create-hook ออกจาก table, อัปเดต section hooks, เพิ่ม section อัปเดต Marketplace
- `.claude-plugin/marketplace.json` — อัปเดต version เป็น 1.5.3

---

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
