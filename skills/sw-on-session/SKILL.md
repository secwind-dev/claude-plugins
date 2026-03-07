---
name: sw-on-session
description: 'โหลด context เข้า session จากไฟล์ใน .claude/sw/session/ หรือจาก path/URL. Usage: /sw-on-session [path|url] [--create]'
argument-hint: '[path|url] [--create]'
disable-model-invocation: true
---

argument ที่รับมา: `$ARGUMENTS`

---

## ขั้นที่ 0 — รับและ Parse Argument

แยก arguments ที่ได้รับ:
- ตรวจว่ามี `--create` flag ใน arguments หรือไม่ → บันทึกไว้เป็น **create_mode** (true/false)
- แยก path/URL ออกจาก arguments (ส่วนที่ไม่ใช่ `--create`) → บันทึกไว้เป็น **target**

ตรวจสอบ:
- ถ้าไม่มี **target** (ไม่มี argument หรือมีแค่ `--create`) → ไปที่ **ขั้นที่ 1**
- ถ้ามี **target** → ไปที่ **ขั้นที่ 3**

---

## ขั้นที่ 1 — ตรวจสอบ Session Folder

รัน Bash tool:

```bash
ls .claude/sw/session/ 2>/dev/null && echo "EXISTS" || echo "NOT_FOUND"
```

- ถ้าผลลัพธ์เป็น `NOT_FOUND` → ไปที่ **ขั้นที่ 1.1**
- ถ้า folder มีอยู่ → ไปที่ **ขั้นที่ 2**

---

## ขั้นที่ 1.1 — สร้าง Session Folder

รัน Bash tool:

```bash
mkdir -p .claude/sw/session/
```

แล้วแจ้ง user:

```
📁 สร้าง folder .claude/sw/session/ เรียบร้อยแล้วค่ะ บอส!

วิธีใช้งาน:
  1. วางไฟล์ที่ต้องการโหลดเป็น context ไว้ใน .claude/sw/session/
     เช่น: .claude/sw/session/project-brief.md
           .claude/sw/session/api-spec.md
  2. รัน /sw-on-session อีกครั้งเพื่อโหลด context ค่ะ

💡 เคล็ดลับ:
  - ไฟล์ใน session/ มีผลแค่ session ปัจจุบัน (ต้องรัน /sw-on-session ทุกครั้งที่เปิด session ใหม่)
  - ถ้าไฟล์มี sensitive data แนะนำเพิ่ม .claude/sw/session/ ใน .gitignore ด้วยนะคะ
```

แล้วหยุด

---

## ขั้นที่ 2 — โหลดไฟล์จาก Session Folder

รัน Bash tool เพื่อ list ไฟล์ทั้งหมด:

```bash
find .claude/sw/session/ -type f | sort
```

- ถ้าไม่มีไฟล์เลย → แจ้ง user:
  ```
  📂 Folder .claude/sw/session/ ยังว่างอยู่นะคะ บอส

  วางไฟล์ที่ต้องการโหลดเป็น context ไว้ใน .claude/sw/session/ แล้วรัน /sw-on-session อีกครั้งค่ะ
  ```
  แล้วหยุด

- ถ้ามีไฟล์ → อ่านทุกไฟล์ด้วย Read tool ทีละไฟล์

หลังอ่านครบแล้ว ให้ทำความเข้าใจและเก็บ content ทั้งหมดไว้ใน session context แล้วไปที่ **ขั้นที่ 4**

---

## ขั้นที่ 3 — Fetch/Read Context จาก path หรือ URL

ตรวจว่า **target** เป็น URL หรือ local path:
- ถ้าขึ้นต้นด้วย `http://` หรือ `https://` → ถือว่าเป็น **URL** → ใช้ WebFetch tool ดึงเนื้อหา
- ถ้าเป็น path อื่น → ถือว่าเป็น **local path** → ใช้ Read tool อ่านไฟล์

- ถ้า fail หรือ error → แจ้ง user:
  ```
  ❌ ไม่สามารถโหลด content ได้ค่ะ บอส
  Target: <target ที่รับมา>

  กรุณาตรวจสอบ:
  - Path หรือ URL ถูกต้อง
  - ถ้าเป็น URL ต้องเป็น public access ได้และ internet connection ปกติ
  - ถ้าเป็น GitHub private repo จะไม่สามารถ fetch ได้โดยตรงค่ะ
  ```
  แล้วหยุด

- ถ้าสำเร็จ → ทำความเข้าใจและเก็บ content ไว้ใน session context
  - ถ้า **create_mode** เป็น true → ไปที่ **ขั้นที่ 3.5**
  - ถ้า **create_mode** เป็น false → ไปที่ **ขั้นที่ 4**

---

## ขั้นที่ 3.5 — สร้างไฟล์ใน .claude/sw/session/

กำหนดชื่อไฟล์จาก **target** ตามลำดับนี้:

1. ถ้าเป็น URL:
   - ตัด query string (`?...`) และ fragment (`#...`) ออกก่อน
   - Strip trailing slash ออก
   - ใช้ last path segment เป็นชื่อไฟล์ เช่น:
     - `https://example.com/docs/api-spec?token=xxx` → `api-spec`
     - `https://example.com/docs/api-spec/` → `api-spec`
   - ถ้า last path segment ว่างหรือหาไม่ได้ (เช่น URL เป็น root `/`) → ใช้ hostname เป็นชื่อไฟล์แทน เช่น `example.com`
2. ถ้าเป็น local path → ใช้ชื่อไฟล์เดิม เช่น `/path/to/project-brief.txt` → `project-brief.txt`
3. ถ้าชื่อไฟล์ที่ได้ไม่มี extension → เติม `.md` ให้อัตโนมัติ

ตรวจสอบว่า `.claude/sw/session/` มีอยู่หรือไม่:

```bash
mkdir -p .claude/sw/session/
```

จากนั้นสร้างไฟล์ใน `.claude/sw/session/<ชื่อไฟล์>` โดยใช้ Write tool บันทึก content ที่ดึงมา

แล้วไปที่ **ขั้นที่ 4**

---

## ขั้นที่ 4 — แสดง Summary

แสดงผลสรุป:

กรณีโหลดจาก folder:
```
✅ โหลด session context สำเร็จแล้วค่ะ บอส!

📂 แหล่งที่มา  : .claude/sw/session/
📄 รายการที่โหลด:
  - <ชื่อไฟล์ที่ 1>
  - <ชื่อไฟล์ที่ 2>
  ...

💡 Context นี้มีผลแค่ session ปัจจุบันนะคะ
   หากต้องการโหลดอีกครั้งในครั้งหน้า ให้รัน /sw-on-session ใหม่ค่ะ
```

กรณีโหลดจาก URL หรือ path (ไม่มี --create):
```
✅ โหลด session context สำเร็จแล้วค่ะ บอส!

🎯 แหล่งที่มา : <path หรือ URL ที่ใช้>
📝 เนื้อหา    : <สรุปสั้นๆ ว่า content นั้นคืออะไร>

💡 Context นี้มีผลแค่ session ปัจจุบันนะคะ
```

กรณีโหลดจาก URL หรือ path พร้อม --create:
```
✅ โหลด session context และสร้างไฟล์สำเร็จแล้วค่ะ บอส!

🎯 แหล่งที่มา : <path หรือ URL ที่ใช้>
💾 บันทึกไว้ที่ : .claude/sw/session/<ชื่อไฟล์>
📝 เนื้อหา    : <สรุปสั้นๆ ว่า content นั้นคืออะไร>

💡 Context นี้จะโหลดอัตโนมัติครั้งหน้าเมื่อรัน /sw-on-session ด้วยนะคะ
```
