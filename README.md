# claude-plugins

**SecWind Claude Plugins** — ชุด skills & hooks สำหรับ Claude Code เพื่อ setup โปรเจกต์, จัดการ hooks, review code, และติดตั้ง MCP servers ได้อย่างรวดเร็ว

---

## 📦 ติดตั้ง

```bash
/plugin marketplace add secwind-dev/claude-plugins
/plugin install sw-claude-plugins@sw-plugins
```

---

## 🛠️ Skills ที่มีให้

| Skill | คำสั่ง | คำอธิบาย |
|-------|--------|----------|
| **sw-init** | `/sw-init <ชื่อโปรเจกต์>` | One-time setup สร้างไฟล์ทั้งหมด (CLAUDE.md, RULE.md, SYSTEM.md, MEMORY.md ฯลฯ) พร้อม default hooks อัตโนมัติ |
| **sw-hook** | `/sw-hook <ชื่อ-hook>` | สร้าง Claude Code hook แบบ guided พร้อม boilerplate และลงทะเบียนใน settings.json |
| **sw-review** | `/sw-review [target]` | Code review จาก git diff พร้อมวิเคราะห์ security, คะแนน quality, และแนะนำ best practices |
| **sw-postgreSQL** | `/sw-postgreSQL` | Setup PostgreSQL ผ่าน Docker สำหรับ local dev พร้อม config, connection string, และ .gitignore |
| **sw-context** | `/sw-context <library> [query]` | โหลด up-to-date docs จาก Context7 สำหรับ library ใดๆ เข้า context |
| **sw-commit** | `/sw-commit` | วิเคราะห์ git diff แล้วสร้าง Conventional Commit message พร้อม confirm ก่อน commit |
| **sw-check** | `/sw-check` | ตรวจสอบ environment: runtime, git config, package manager, และ .env security |

---

## 🪝 Default Hooks (สร้างอัตโนมัติโดย sw-init)

| Hook | Event | ทำอะไร |
|------|-------|--------|
| `track-action.sh` | PreToolUse | จับ action ล่าสุดของ Claude (Write, Edit, Bash, git ฯลฯ) |
| `notify-done.sh` | Stop | popup + เสียง + พูดภาษาไทยแจ้งว่าทำอะไรเสร็จ |

---

## 🔄 อัปเดต Marketplace

เมื่อ deploy version ใหม่ ให้อัปเดต version ใน 3 ไฟล์นี้ให้ตรงกัน:

| ไฟล์ | field |
|------|-------|
| `.claude-plugin/plugin.json` | `"version"` |
| `.claude-plugin/marketplace.json` | `"metadata.version"` และ `"plugins[0].version"` |
| `CHANGELOG.md` | entry header เช่น `## [YYYY-MM-DD] — vX.X.X` |

จากนั้น commit และ push — marketplace จะดึง version ใหม่จาก GitHub โดยอัตโนมัติ

---

## 👤 Author

**SecWind** — secwind.dev@gmail.com
