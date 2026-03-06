---
name: sw-on-session
description: 'โหลด context เข้า session จากไฟล์ใน .claude/sw/session/ หรือจาก URL. Usage: /sw-on-session [url]'
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

## ขั้นที่ 3 — Fetch Context จาก URL

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

- ถ้าสำเร็จ → ทำความเข้าใจและเก็บ content ไว้ใน session context แล้วไปที่ **ขั้นที่ 4**

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

กรณีโหลดจาก URL:
```
✅ โหลด session context จาก URL สำเร็จแล้วค่ะ บอส!

🌐 URL        : <url ที่ fetch มา>
📝 เนื้อหา    : <สรุปสั้นๆ ว่า content นั้นคืออะไร>

💡 Context นี้มีผลแค่ session ปัจจุบันนะคะ
```
