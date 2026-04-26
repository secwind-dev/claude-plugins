## 🛠️ Skills ทั้งหมด

### `/sw-init <ชื่อโปรเจกต์>`

**One-time setup** — สร้างไฟล์ทั้งหมดสำหรับโปรเจกต์ใหม่ในครั้งเดียว

สร้างไฟล์เหล่านี้อัตโนมัติ:

- `CLAUDE.md` — คำสั่งและ routing table สำหรับ Claude
- `.claude/sw/RULE.md` — กฎความปลอดภัย
- `.claude/sw/SOUL.md` — ตัวตนและบุคลิกภาพ
- `.claude/sw/MEMORY.md` — ความทรงจำข้ามเซสชั่น
- `.claude/sw/PROJECT.md` — ข้อมูลโปรเจกต์
- `.claude/sw/DEPLOY.md` — คู่มือ deploy
- `CHANGELOG.md` — บันทึกการเปลี่ยนแปลง
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

### `/sw-explore [topic] [file1] [file2]...`

**สำรวจ topic ซับซ้อน** — ถามตอบแบบ interactive เพื่อช่วย user เรียบเรียงความต้องการที่ยังไม่ชัดเจน บันทึกผลลง `.claude/sw/explore/<topic>/`

- ไม่ระบุ topic → ถามก่อน
- โยนไฟล์ได้เลย (PDF, Excel ฯลฯ) — copy เข้า topic folder + โหลดเข้า context อัตโนมัติ
- ตรวจ session เก่าอัตโนมัติ — ถ้าโยนไฟล์มาจะต่อจากเดิมเลยโดยไม่ถาม
- ทุกรอบ Q&A มี `✏️ พิมพ์เองค่ะ` และ `❓ ถามไอโกะกลับ` เสมอ
- Aiko ออกความเห็นหลังทุกคำตอบ แต่การตัดสินใจเป็นของ user เสมอ

---

### `/sw-deploy`

**Deploy โปรเจกต์** — อ่านและทำตาม `.claude/sw/DEPLOY.md` ทีละขั้นโดยอัตโนมัติ

- ถ้าไม่มี `DEPLOY.md` → แจ้ง user ให้รัน `/sw-init` ก่อน

---

### `/sw-commit`

**สร้าง Conventional Commit message** — วิเคราะห์ git diff แล้วสร้าง message พร้อม confirm ก่อน commit

รูปแบบ: `<type>(<scope>): <description>`
Types: `feat` / `fix` / `docs` / `refactor` / `style` / `test` / `chore` / `perf` / `ci`

---

### `/sw-review [target]`

**Code review** — วิเคราะห์ git diff แบบละเอียดพร้อม confidence level ต่อ issue

- ไม่ระบุ target → `git diff HEAD` (uncommitted changes)
- ระบุ target → เช่น `/sw-review main`, `/sw-review HEAD~3`

แสดงผล: สรุปการเปลี่ยนแปลง / จุดดี / จุดเสี่ยง (พร้อม `🔴 HIGH / 🟡 MED / ⚪ LOW`) / Breaking Changes / Security / CLAUDE.md Compliance / คะแนน

> ดึง `CLAUDE.md` และ `git log` ของไฟล์ที่เปลี่ยนมาประกอบการวิเคราะห์เพื่อลด false positive

---

### `/sw-hook <ชื่อ-hook>`

**สร้าง Claude Code hook** — guided wizard พร้อม boilerplate ครบ

- ถามว่า hook ตอบสนองต่อ event ไหน (PreToolUse / PostToolUse / Stop ฯลฯ)
- สร้างไฟล์ `.claude/hooks/<ชื่อ>.sh` พร้อม boilerplate
- ลงทะเบียนใน `.claude/settings.json` อัตโนมัติ

---

### `/sw-adc <ชื่อ function>`

**สร้าง function ใน ADC style** — รับ function signature แล้วสร้าง code แบบ Functional Programming พร้อมแนะนำ function ต่อยอด

ตัวอย่าง:

- `/sw-adc emailValid(email: string)`
- `/sw-adc getIncludeVat(price: number, vat: number)`

แสดงผล: code เต็มพร้อม comment ภาษาไทย + import ที่ต้องเพิ่ม + แนะนำ 3 function ที่ต่อยอดได้ทันที

> อ้างอิง `.claude/sw/ADC.md` — ดึงจาก GitHub อัตโนมัติถ้ายังไม่มีไฟล์

---

### `/sw-refactor-code <path> [query]`

**Refactor code** — อ่านไฟล์หรือ directory แล้ว refactor ตาม rule ใน `.claude/sw/REFACTOR.md`

- `/sw-refactor-code src/utils/helper.ts`
- `/sw-refactor-code src/components/ focus on readability`

แสดงผล: รายการเปลี่ยนแปลงพร้อม file:line / สิ่งที่ไม่แก้พร้อมเหตุผล / คำแนะนำเพิ่มเติม

> สร้าง `REFACTOR.md` ให้อัตโนมัติถ้ายังไม่มี รองรับ Functional Programming style

---

### `/sw-generate <path/file>`

**สร้างไฟล์จาก response ล่าสุด** — ดึง code block หรือ content จาก response ก่อนหน้าแล้วบันทึกเป็นไฟล์

ตัวอย่าง:

- `/sw-generate src/utils/emailValid.ts` — ดึงเฉพาะ code block
- `/sw-generate docs/summary.md` — ดึง content ทั้งหมด

> Code file → ดึงเฉพาะ code block | Text/Doc file → ดึง content ทั้งหมด

---

### `/sw-secret [path]`

**สแกน hardcoded secrets** — ตรวจหา API keys, passwords, private keys, AWS credentials ใน codebase

- ไม่ระบุ path → สแกนทั้งโปรเจกต์
- ระบุ path → สแกนเฉพาะ directory/file นั้น

แสดงผล: findings จัดกลุ่มตาม severity (Critical/Warning/Info) + .gitignore coverage

---

### `/sw-audit [path]`

**Security audit แบบ comprehensive** — ตรวจ OWASP Top 10 patterns, hardcoded secrets, dependency vulnerabilities, และ config safety

- ไม่ระบุ → audit ทั้งโปรเจกต์
- `<path>` → audit เฉพาะ path นั้น

แสดงผล: Risk Score (0-100), findings จัดกลุ่ม Critical/High/Medium/Low, คำแนะนำเรียงลำดับ priority

> แนะนำให้เปิด session ใหม่หลัง audit เสมอ เพื่อให้ Claude มี context เต็มสำหรับงานถัดไป

---

### `/sw-version`

**แสดง version** — เช็ค version ของ sw-claude-plugins ที่ติดตั้งอยู่ในปัจจุบัน

---

### `/sw-doctor`

**ตรวจสอบ version** — เช็คว่า plugin ที่ติดตั้งอยู่เป็น version ล่าสุดหรือยัง

- เปรียบเทียบ local version กับ GitHub
- ถ้ามี version ใหม่ → แสดง changelog + คำสั่ง update
- ถ้าเป็น version ล่าสุดแล้ว → แจ้งว่าไม่ต้องทำอะไร

---

### `/sw-awaken [url]`

**ความรู้ถาวรข้ามทุก session** — สอนไอโกะให้รู้จักบางอย่างตลอดไป เช่น ข้อมูลบริษัท, spec โปรเจกต์

- ไม่ระบุ argument → โหลดไฟล์ทั้งหมดใน `.claude/sw/awaken/` เข้า context
- ระบุ URL → fetch เนื้อหา + **บันทึกเป็นไฟล์ถาวร** ใน `.claude/sw/awaken/`
- ถ้ายังไม่มี folder → สร้างให้อัตโนมัติ + ตั้งค่า auto-load ใน `SOUL.md`

> ✨ ความรู้ใน `awaken/` จะ **auto-load ทุก session** โดยอัตโนมัติ ไม่ต้องรันซ้ำ
> ⚠️ ไฟล์ใหญ่มากอาจกิน context window ทุก session — แนะนำเก็บเฉพาะข้อมูลสำคัญ

---

### `/sw-on-session [url]`

**โหลด session context** — โหลดข้อมูลเข้า context window ของ session ปัจจุบัน

- ไม่ระบุ argument → อ่านไฟล์ทั้งหมดใน `.claude/sw/session/` แล้ว load เข้า context
- ระบุ URL → fetch เนื้อหาจาก URL แล้ว load เข้า context
- ถ้ายังไม่มี folder `.claude/sw/session/` → สร้างให้อัตโนมัติพร้อมแนะนำวิธีใช้

> ⚠️ Context มีผลแค่ session ปัจจุบัน — ต้องรัน `/sw-on-session` ใหม่ทุกครั้งที่เปิด session ใหม่
> แนะนำเพิ่ม `.claude/sw/session/` ใน `.gitignore` ถ้ามีไฟล์ sensitive

---

### `/sw-docs`

**คู่มือการใช้งาน** — ดึงไฟล์นี้จาก GitHub มาแสดงสดทุกครั้ง (เสมอ up-to-date)
