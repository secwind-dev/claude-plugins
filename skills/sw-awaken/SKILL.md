---
name: sw-awaken
description: 'เพิ่มความรู้ถาวรให้อิงโกะจำข้ามทุก session จากไฟล์ใน .claude/sw/awaken/ หรือจาก URL. Usage: /sw-awaken [url]'
argument-hint: '[url]'
disable-model-invocation: true
---

argument ที่รับมา: `$ARGUMENTS`

---

## ขั้นที่ 0 — รับ Argument

ตรวจสอบ argument ที่ได้รับ:
- ถ้ามี argument → ถือว่าเป็น URL → ไปที่ **ขั้นที่ 3**
- ถ้าไม่มี argument → ไปที่ **ขั้นที่ 1**

---

## ขั้นที่ 1 — ตรวจสอบ Awaken Folder

รัน Bash tool:

```bash
ls .claude/sw/awaken/ 2>/dev/null && echo "EXISTS" || echo "NOT_FOUND"
```

- ถ้าผลลัพธ์เป็น `NOT_FOUND` → ไปที่ **ขั้นที่ 1.1**
- ถ้า folder มีอยู่ → ไปที่ **ขั้นที่ 2**

---

## ขั้นที่ 1.1 — สร้าง Awaken Folder + Update SYSTEM.md

รัน Bash tool:

```bash
mkdir -p .claude/sw/awaken/
```

จากนั้นอ่าน `.claude/sw/SYSTEM.md` ด้วย Read tool เพื่อตรวจสอบว่ามี awaken directive แล้วหรือยัง

- ถ้ายังไม่มีส่วน `## 🌅 Awaken Knowledge` → เพิ่ม section นี้ต่อท้าย SYSTEM.md ด้วย Edit tool:

```markdown

## 🌅 Awaken Knowledge

ถ้ามีไฟล์ใน `.claude/sw/awaken/` → อ่านทุกไฟล์เพื่อโหลดความรู้ถาวรของอิงโกะ
```

แล้วแจ้ง user:

```
🌅 พร้อมรับ Awaken Knowledge แล้วค่ะ บอส!

✅ สร้าง folder .claude/sw/awaken/ เรียบร้อยแล้ว
✅ อัปเดต SYSTEM.md ให้ auto-load ความรู้ทุก session แล้ว

วิธีเพิ่มความรู้ถาวร:

  1. วางไฟล์ไว้ใน .claude/sw/awaken/ เช่น:
       .claude/sw/awaken/company.md       ← ข้อมูลบริษัท
       .claude/sw/awaken/project-spec.md  ← spec โปรเจกต์

  2. หรือ fetch จาก URL ตรงเลย:
       /sw-awaken https://your-url.com/info

  3. รัน /sw-awaken อีกครั้งเพื่อโหลดเข้า session ปัจจุบันค่ะ

💡 ความรู้ใน awaken/ จะ auto-load ทุกครั้งที่เปิด session ใหม่
   โดยไม่ต้องรันคำสั่งซ้ำค่ะ
```

แล้วหยุด

---

## ขั้นที่ 2 — โหลดไฟล์จาก Awaken Folder

รัน Bash tool เพื่อ list ไฟล์ทั้งหมด:

```bash
find .claude/sw/awaken/ -type f | sort
```

- ถ้าไม่มีไฟล์เลย → แจ้ง user:
  ```
  📂 Folder .claude/sw/awaken/ ยังว่างอยู่นะคะ บอส

  เพิ่มความรู้ถาวรได้ด้วย:
  - วางไฟล์ไว้ใน .claude/sw/awaken/ แล้วรัน /sw-awaken อีกครั้ง
  - หรือ fetch จาก URL: /sw-awaken https://...
  ```
  แล้วหยุด

- ถ้ามีไฟล์ → อ่านทุกไฟล์ด้วย Read tool ทีละไฟล์

จากนั้นตรวจสอบว่า `.claude/sw/SYSTEM.md` มี awaken directive แล้วหรือยัง:
- ถ้ายังไม่มี → เพิ่ม section `## 🌅 Awaken Knowledge` ต่อท้าย SYSTEM.md

หลังอ่านและเก็บ content ทั้งหมดเข้า session context แล้ว → ไปที่ **ขั้นที่ 4**

---

## ขั้นที่ 3 — Fetch จาก URL และ Save เป็นไฟล์ถาวร

ใช้ WebFetch tool ดึงเนื้อหาจาก URL ที่รับมา:
- URL = argument ที่ได้รับ

- ถ้า fail หรือ error → แจ้ง user:
  ```
  ❌ ไม่สามารถ fetch URL ได้ค่ะ บอส
  URL: <url ที่รับมา>

  กรุณาตรวจสอบ:
  - URL ถูกต้องและ public access ได้
  - Internet connection ปกติ
  - ถ้าเป็น GitHub private repo จะไม่สามารถ fetch ได้โดยตรงค่ะ
  ```
  แล้วหยุด

- ถ้าสำเร็จ:
  - สร้าง folder `.claude/sw/awaken/` ถ้ายังไม่มี: `mkdir -p .claude/sw/awaken/`
  - ตั้งชื่อไฟล์จาก URL โดยแปลง URL เป็น slug (เช่น `github-com-secwind-dev-readme.md`)
    - เอาเฉพาะส่วน path ของ URL มาแปลงเป็น kebab-case
    - ต้องลงท้ายด้วย `.md`
  - บันทึก content ลงไฟล์ใน `.claude/sw/awaken/<filename>.md` ด้วย Write tool
  - Load เนื้อหาเข้า session context
  - ตรวจสอบและ ensure SYSTEM.md มี awaken directive (เพิ่มถ้าไม่มี)
  - ไปที่ **ขั้นที่ 4**

---

## ขั้นที่ 4 — แสดง Summary

กรณีโหลดจาก folder:
```
🌅 Awaken สำเร็จแล้วค่ะ บอส! อิงโกะจะจำสิ่งเหล่านี้ตลอดไปนะคะ

📂 แหล่งที่มา  : .claude/sw/awaken/
📄 รายการที่โหลด:
  - <ชื่อไฟล์ที่ 1>
  - <ชื่อไฟล์ที่ 2>
  ...

✨ ความรู้เหล่านี้จะ auto-load ทุก session โดยอัตโนมัติค่ะ
```

กรณีโหลดจาก URL:
```
🌅 Awaken จาก URL สำเร็จแล้วค่ะ บอส!

🌐 URL        : <url ที่ fetch มา>
💾 บันทึกเป็น : .claude/sw/awaken/<filename>.md
📝 เรียนรู้   : <สรุปสั้นๆ ว่าเนื้อหานั้นคืออะไร>

✨ อิงโกะจะจำข้อมูลนี้ตลอดไปนะคะ — auto-load ทุก session ค่ะ
```
