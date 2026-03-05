# SecWind Claude Plugins — คู่มือการใช้งาน

**Version:** 1.6.0
**Repository:** https://github.com/secwind-dev/claude-plugins

---

## 📦 ติดตั้ง

```
/plugin marketplace add secwind-dev/claude-plugins
/plugin install sw-claude-plugins@sw-plugins
```

---

## 🛠️ Skills ทั้งหมด

### `/sw-init <ชื่อโปรเจกต์>`
**One-time setup** — สร้างไฟล์ทั้งหมดสำหรับโปรเจกต์ใหม่ในครั้งเดียว

สร้างไฟล์เหล่านี้อัตโนมัติ:
- `CLAUDE.md` — คำสั่งและ routing table สำหรับ Claude
- `.claude/sw/RULE.md` — กฎความปลอดภัย
- `.claude/sw/SYSTEM.md` — ตัวตนและบุคลิกภาพ
- `.claude/sw/MEMORY.md` — ความทรงจำข้ามเซสชั่น
- `.claude/sw/PROJECT.md` — ข้อมูลโปรเจกต์
- `.claude/sw/PACKAGES.md` — บันทึก dependencies
- `.claude/sw/DEPLOY.md` — คู่มือ deploy
- `.claude/hooks/` — default hooks (track-action + notify-done)

---

### `/sw-check`
**ตรวจสอบ environment** — รันครั้งเดียวได้ dashboard สรุปทันที

ตรวจสอบ:
- Node.js / Bun version
- Git user.name / user.email
- Package manager (npm / yarn / bun / pnpm)
- `.env` safety (gitignored หรือยัง)
- `.claude/` safety (gitignored หรือยัง)

---

### `/sw-commit`
**สร้าง Conventional Commit message** — วิเคราะห์ git diff แล้วสร้าง message พร้อม confirm ก่อน commit

รูปแบบ: `<type>(<scope>): <description>`
Types: `feat` / `fix` / `docs` / `refactor` / `style` / `test` / `chore` / `perf` / `ci`

---

### `/sw-review [target]`
**Code review** — วิเคราะห์ git diff แล้วแสดงผลแบบละเอียด

- ไม่ระบุ target → `git diff HEAD` (uncommitted changes)
- ระบุ target → เช่น `/sw-review main`, `/sw-review HEAD~3`

แสดงผล: สรุปการเปลี่ยนแปลง / จุดดี / จุดเสี่ยง / Security / Best Practice / คะแนน

---

### `/sw-hook <ชื่อ-hook>`
**สร้าง Claude Code hook** — guided wizard พร้อม boilerplate ครบ

- ถามว่า hook ตอบสนองต่อ event ไหน (PreToolUse / PostToolUse / Stop ฯลฯ)
- สร้างไฟล์ `.claude/hooks/<ชื่อ>.sh` พร้อม boilerplate
- ลงทะเบียนใน `.claude/settings.json` อัตโนมัติ

---

### `/sw-context <library> [query]`
**โหลด documentation สด** — ดึง up-to-date docs จาก Context7 เข้า context ทันที

ตัวอย่าง:
- `/sw-context react` — โหลด React docs
- `/sw-context prisma how to use transactions` — โหลดพร้อม query เฉพาะเจาะจง

---

### `/sw-postgreSQL`
**Setup PostgreSQL** — สร้าง `docker-compose.yml` + `.env` สำหรับ local development

- ถาม container name / database name / port / PG version
- สร้างไฟล์แยก credentials ออกจาก config
- Start Docker Compose ได้เลยถ้าต้องการ

---

### `/sw-doctor`
**ตรวจสอบ version** — เช็คว่า plugin ที่ติดตั้งอยู่เป็น version ล่าสุดหรือยัง

- เปรียบเทียบ local version กับ GitHub
- ถ้ามี version ใหม่ → แสดง changelog + คำสั่ง update
- ถ้าเป็น version ล่าสุดแล้ว → แจ้งว่าไม่ต้องทำอะไร

---

### `/sw-docs`
**คู่มือการใช้งาน** — ดึงไฟล์นี้จาก GitHub มาแสดงสดทุกครั้ง (เสมอ up-to-date)

---

## 🪝 Default Hooks

สร้างอัตโนมัติโดย `sw-init`:

| Hook | Event | ทำอะไร |
|------|-------|---------|
| `track-action.sh` | PreToolUse | จับ action ล่าสุดของ Claude (Write, Edit, Bash, git ฯลฯ) |
| `notify-done.sh` | Stop | popup + เสียง + พูดภาษาไทยแจ้งว่าทำอะไรเสร็จ |

---

## 🔄 อัปเดต

```
/plugin marketplace update sw-plugins
/plugin update sw-claude-plugins@sw-plugins
```

---

## 👤 Author

**SecWind** — secwind.dev@gmail.com
https://github.com/secwind-dev/claude-plugins
