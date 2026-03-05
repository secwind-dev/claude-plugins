---
name: sw-context
description: 'Load up-to-date documentation from Context7 for any library. Usage: /sw-context <library-name> [query]'
argument-hint: <library-name> [query]
disable-model-invocation: true
---


path รับมา: `$ARGUMENTS`

---

## ขั้นที่ 0 — รับ Argument

แยก argument ที่ได้รับ:
- argument แรก = `library-name`
- argument ที่เหลือ = `query` (optional)

ตัวอย่าง:
- `/sw-context react` → library=`react`, query=ว่าง
- `/sw-context react hooks` → library=`react`, query=`hooks`

ถ้าไม่มี argument → แจ้ง user ว่า "กรุณาระบุชื่อ library ด้วยนะคะ บอส เช่น `/sw-context react`" แล้วหยุด

---

## ขั้นที่ 1 — Resolve Library ID

ใช้ MCP tool `resolve-library-id`:
- ส่ง `libraryName` = ชื่อ library จาก argument
- ส่ง `query` = query ที่รับมา (หรือ `"getting started overview"` ถ้าไม่มี)

---

## ขั้นที่ 2 — Query Documentation

ใช้ MCP tool `query-docs`:
- ส่ง `libraryId` = ID ที่ได้จากขั้นที่ 1
- ส่ง `query` = query ที่รับมา (หรือ `"getting started overview"` ถ้าไม่มี)

---

## ขั้นที่ 3 — แจ้งผล

แสดงผลสรุป:

```
✅ โหลด docs สำเร็จแล้วค่ะ บอส!

📚 Library : <ชื่อ library>
🔍 Query   : <query ที่ใช้>
📝 Snippets: <จำนวน snippets ที่ได้>

Docs พร้อมใช้งานใน context แล้วค่ะ 🚀
```
