---
name: sw-generate
description: 'สร้างไฟล์จาก response ล่าสุดในการสนทนา — ถ้าเป็น code file ดึงเฉพาะ code block ที่สมบูรณ์, ถ้าเป็น text/doc file เขียน content ทั้งหมด Usage: /sw-generate <path/file>'
argument-hint: '<path/file เช่น ".test/func.ts" หรือ "docs/GOLD.md">'
disable-model-invocation: true
---
---

## ขั้นที่ 0 — รับ Argument และตรวจสอบ

argument ที่รับมา: `$ARGUMENTS`

ถ้าไม่มี argument → แจ้ง user:

```
กรุณาระบุ path/file ที่ต้องการสร้างด้วยนะคะ บอส

Usage: /sw-generate <path/file>
ตัวอย่าง:
  /sw-generate .test/func.ts        → สร้างไฟล์ TypeScript จาก code ใน response ล่าสุด
  /sw-generate src/utils/helper.js  → สร้างไฟล์ JavaScript
  /sw-generate docs/GOLD.md         → สร้างไฟล์ Markdown จาก content ใน response ล่าสุด
  /sw-generate notes/summary.txt    → สร้างไฟล์ text
```

แล้วหยุด

---

## ขั้นที่ 1 — ระบุประเภทไฟล์

ดึง extension จาก argument:

- **Code file** (ดึงเฉพาะ code block):
  `.ts`, `.tsx`, `.js`, `.jsx`, `.py`, `.go`, `.rs`, `.java`, `.kt`, `.swift`,
  `.c`, `.cpp`, `.cs`, `.php`, `.rb`, `.sh`, `.bash`, `.zsh`, `.sql`

- **Text/Doc file** (เขียน content ทั้งหมดของ response):
  `.md`, `.txt`, `.json`, `.yaml`, `.yml`, `.toml`, `.env.example`, `.csv`, `.xml`, `.html`, `.css`

ถ้า extension ไม่อยู่ในรายการ → ถือว่าเป็น **Text/Doc file**

---

## ขั้นที่ 2 — มองหา Content จาก Response ล่าสุด

มองย้อนกลับไปที่ **response ล่าสุดของ AI ก่อน message ที่ user พิมพ์ `/sw-generate`** (ไม่ใช่ message ของ user และไม่ใช่ tool output ระหว่าง skill นี้รัน)

### กรณี Code file

ค้นหา code block ตามลำดับ priority:

1. **Priority สูงสุด** — หา section ที่มีหัวข้อ:
   - `✅ Code ที่สร้างทั้งหมด:` หรือ `✅ Code ที่แปลงแล้วทั้งหมด:`
   - แล้วดึง code block (` ``` `) ที่อยู่ใต้หัวข้อนั้น

2. **Fallback** — ถ้าไม่มี section ดังกล่าว → ดึง code block สุดท้ายใน response นั้น

3. ถ้าไม่มี code block เลยใน response → แจ้ง user:
   ```
   ไม่พบ code ใน response ล่าสุดค่ะ บอส
   response ล่าสุดเป็น text ธรรมดา — ลองใช้ .md หรือ .txt แทนได้นะคะ

   ตัวอย่าง: /sw-generate <path/file>.md
   ```
   แล้วหยุด

### กรณี Text/Doc file

ดึง **content ทั้งหมดของ response ล่าสุด** มาใช้เป็น content ของไฟล์ตรงๆ
(รวม markdown, bullet points, headers, tables ทุกอย่างตามที่ตอบไป)

---

## ขั้นที่ 3 — สร้างไฟล์

ใช้ Bash tool สร้าง directory ถ้ายังไม่มี (แทนที่ `$ARGUMENTS` ด้วยค่าจริงจาก argument):

```bash
mkdir -p "$(dirname '$ARGUMENTS')"
```

จากนั้นใช้ Write tool เขียน content ลงไฟล์ที่ระบุใน argument

---

## ขั้นที่ 4 — แจ้งผล

แสดงผลในรูปแบบ:

```
✅ สร้างไฟล์สำเร็จค่ะ บอส!

📄 File   : <path/file>
📦 Source : <"code block จาก ✅ summary section" | "code block สุดท้าย" | "content ทั้งหมดของ response">
📏 Size   : <จำนวนบรรทัด> บรรทัด
```
