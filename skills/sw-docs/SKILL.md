---
name: sw-docs
description: 'แสดงคู่มือการใช้งาน sw-claude-plugins ทั้งหมด โดยดึงข้อมูลสดจาก GitHub เสมอ. Usage: /sw-docs'
disable-model-invocation: true
---
---

## ขั้นที่ 1 — ดึง DOCS.md จาก GitHub

รัน Bash tool:

```bash
curl -sf "https://raw.githubusercontent.com/secwind-dev/claude-plugins/main/DOCS.md"
```

- ถ้าสำเร็จ → นำ content ไปแสดงในขั้นที่ 2
- ถ้า fail → แจ้ง user:
  ```
  ❌ ไม่สามารถเชื่อมต่อ GitHub ได้ค่ะ บอส
  กรุณาตรวจสอบ internet connection แล้วลองใหม่นะคะ
  ```
  แล้วหยุด

---

## ขั้นที่ 2 — แสดงผล

แสดง content ที่ได้จาก DOCS.md ทั้งหมดให้ user เห็นโดยตรง — ไม่ต้องสรุปหรือแปลงรูปแบบ
