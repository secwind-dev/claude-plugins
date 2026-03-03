# PROJECT.md

## ข้อมูลโปรเจกต์

- **ชื่อโปรเจกต์:** claude-plugins
- **คำอธิบาย:** ชุด Custom Skills และ Hooks สำหรับ Claude Code — ช่วยให้ทำงานซ้ำๆ ได้เร็วขึ้นผ่านคำสั่ง `/sw-*` และ `/create` โดยไม่ต้องเขียน prompt ใหม่ทุกครั้ง
- **เริ่มต้น:** 2026-03-03

---

## 🛠️ Tech Stack

- **Platform:** Claude Code (Skills system)
- **Format:** Markdown (`.md`) — ทุก skill เขียนเป็น prompt ใน SKILL.md
- **Versioning:** @changesets/cli (planned)
- **Language:** ภาษาไทย เป็นหลัก

---

## 📁 โครงสร้างโปรเจกต์

```
claude-plugins/
├── CLAUDE.md               ← Startup rules & routing สำหรับ Claude
├── CHANGELOG.md            ← บันทึกการเปลี่ยนแปลงทั้งหมด
├── .claude/
│   └── sw/                 ← ไฟล์ config ของ sw system
│       ├── RULE.md         ← กฎความปลอดภัย
│       ├── SYSTEM.md       ← ตัวตน/บุคลิกภาพของ Claude (อิงโกะ)
│       ├── PROJECT.md      ← ข้อมูลโปรเจกต์ (ไฟล์นี้)
│       ├── MEMORY.md       ← ความทรงจำข้ามเซสชัน
│       ├── PACKAGES.md     ← รายการ packages
│       └── DEPLOY.md       ← คู่มือ deploy
└── skills/                 ← รวม custom skills ทั้งหมด
    ├── sw-init/
    │   └── SKILL.md        ← One-time project setup wizard
    └── create/
        └── SKILL.md        ← สร้างไฟล์พร้อม boilerplate ตาม extension
```

---

## ⚡ Skills ที่มี

| Skill | คำสั่ง | ทำอะไร |
|-------|--------|--------|
| sw-init | `/sw-init <ชื่อโปรเจกต์>` | Setup โปรเจกต์ใหม่ สร้างไฟล์ทั้งหมด 8 ไฟล์ |
| create | `/create <path/to/file.ext>` | สร้างไฟล์พร้อม boilerplate ตามนามสกุล |
