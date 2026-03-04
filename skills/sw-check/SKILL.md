---
name: sw-check
description: 'Validate development environment: runtime, git config, package manager, and .env security. Usage: /sw-check'
disable-model-invocation: true
---

เรียก user ว่า **บอส** เสมอ

ทำทุกอย่างอัตโนมัติ — ตรวจสอบ environment แล้วแสดง dashboard สรุป

---

## ขั้นที่ 1 — ตรวจ Runtime

รัน Bash commands:

```bash
node --version 2>/dev/null && echo "NODE_OK" || echo "NODE_NOT_FOUND"
```

```bash
bun --version 2>/dev/null && echo "BUN_OK" || echo "BUN_NOT_FOUND"
```

บันทึกผล:
- ✅ ถ้าพบ version → แสดง version
- ❌ ถ้าไม่พบ → แสดงสถานะ "ไม่พบ"

---

## ขั้นที่ 2 — ตรวจ Git Config

รัน Bash commands:

```bash
git config user.name
```

```bash
git config user.email
```

บันทึกผล:
- ✅ ถ้ามีค่า → แสดง name/email
- ⚠️ ถ้าว่าง → แสดง "ยังไม่ได้ตั้งค่า"

---

## ขั้นที่ 3 — ตรวจ Package Manager

รัน Bash tool:

```bash
ls package-lock.json yarn.lock bun.lockb pnpm-lock.yaml 2>/dev/null
```

บันทึกผล:
- `package-lock.json` → **npm**
- `yarn.lock` → **yarn**
- `bun.lockb` → **bun**
- `pnpm-lock.yaml` → **pnpm**
- ไม่พบ lock file ใดๆ → **ไม่พบ package manager**

---

## ขั้นที่ 4 — ตรวจ .env ใน .gitignore

รัน Bash commands (ตรวจแค่การมีอยู่ ไม่อ่านเนื้อหา):

```bash
test -f .env && echo "ENV_EXISTS" || echo "ENV_NOT_FOUND"
```

ถ้าพบ `.env`:

```bash
grep -q "^\.env" .gitignore 2>/dev/null && echo "GITIGNORE_OK" || echo "GITIGNORE_MISSING"
```

บันทึกผล:
- ไม่มี `.env` → ✅ ไม่มีไฟล์ .env
- มี `.env` + อยู่ใน `.gitignore` → ✅ ปลอดภัย
- มี `.env` + ไม่อยู่ใน `.gitignore` → 🚨 WARNING: .env ไม่อยู่ใน .gitignore!

---

## ขั้นที่ 5 — ตรวจ .claude/ ใน .gitignore

รัน Bash command:

```bash
grep -qxF '.claude/' .gitignore 2>/dev/null && echo "CLAUDE_GITIGNORE_OK" || echo "CLAUDE_GITIGNORE_MISSING"
```

บันทึกผล:
- **OK** → ✅ `.claude/` อยู่ใน `.gitignore` แล้ว
- **MISSING** → 🚨 `.claude/` ไม่อยู่ใน `.gitignore` → ถาม user ด้วย `AskUserQuestion`:
  - **question:** "พบว่า `.claude/` ยังไม่อยู่ใน `.gitignore` นะคะ บอส — อิงโกะจะ add ให้และ untrack จาก git เลยไหมคะ?"
  - **header:** ".claude/ Safety"
  - **options:**
    - `✅ ทำเลย` — description: "append `.claude/` ใน .gitignore และรัน `git rm -r --cached .claude/`"
    - `❌ ข้ามไป` — description: "ไม่ทำอะไร บันทึกเป็น WARNING ใน dashboard"

  ถ้า user เลือก **✅ ทำเลย**:
  ```bash
  printf '\n.claude/\n' >> .gitignore
  ```
  ```bash
  git rm -r --cached .claude/ 2>/dev/null || true
  ```
  → อัปเดตสถานะเป็น ✅ แก้ไขแล้ว

---

## ขั้นที่ 6 — แสดง Dashboard

รวบรวมผลทั้งหมดแล้วแสดงตาราง:

```
🔍 Environment Check — สรุปผลการตรวจสอบ

| รายการ           | สถานะ | รายละเอียด                     |
|------------------|-------|--------------------------------|
| Node.js          | ✅/❌  | vX.X.X / ไม่พบ                |
| Bun              | ✅/❌  | vX.X.X / ไม่พบ                |
| Git user.name    | ✅/⚠️  | <ชื่อ> / ยังไม่ได้ตั้งค่า      |
| Git user.email   | ✅/⚠️  | <email> / ยังไม่ได้ตั้งค่า     |
| Package Manager  | ✅/⚠️  | npm/yarn/bun/pnpm / ไม่พบ     |
| .env Safety      | ✅/🚨  | ปลอดภัย / WARNING!             |
| .claude/ Safety  | ✅/🚨  | อยู่ใน .gitignore / WARNING!   |
```

ถ้ามี 🚨 `.env` ที่ยังค้างอยู่ → แนะนำให้รัน:
```bash
echo ".env" >> .gitignore
```
