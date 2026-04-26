# claude-plugins

**SecWind Claude Plugins** — ชุด skills & hooks สำหรับ Claude Code เพื่อ setup โปรเจกต์, จัดการ hooks, review code, และติดตั้ง MCP servers ได้อย่างรวดเร็ว

> 🎯 **Vision:** สร้าง plugin ecosystem ที่เป็น standard สำหรับ AI setup — คำนึงถึงมาตรฐานเครื่องมือ, การจัดการ API token อย่างปลอดภัย, และการบริหาร context window อย่างมีประสิทธิภาพ

---

## 📦 ติดตั้ง & อัปเดต

### ติดตั้งครั้งแรก

```bash
/plugin marketplace add secwind-dev/claude-plugins
/plugin install sw-claude-plugins@sw-plugins
```

### อัปเดต plugin ที่ติดตั้งอยู่

```bash
/plugin marketplace update sw-plugins        # รีเฟรช catalog ให้เห็น version ล่าสุด
/plugin update sw-claude-plugins@sw-plugins  # อัปเดต plugin ให้เป็น version ล่าสุด
```

---

## 🛠️ Skills ที่มีให้

| Skill | คำสั่ง | คำอธิบาย |
|-------|--------|----------|
| **sw-init** | `/sw-init <ชื่อโปรเจกต์>` | One-time setup สร้างไฟล์ทั้งหมด (CLAUDE.md, RULE.md, SOUL.md, MEMORY.md ฯลฯ) พร้อม default hooks อัตโนมัติ |
| **sw-hook** | `/sw-hook <ชื่อ-hook>` | สร้าง Claude Code hook แบบ guided พร้อม boilerplate และลงทะเบียนใน settings.json |
| **sw-review** | `/sw-review [target]` | Code review จาก git diff พร้อมวิเคราะห์ security, คะแนน quality, และแนะนำ best practices |
| **sw-explore** | `/sw-explore [topic]` | สำรวจ topic ซับซ้อนผ่านการถามตอบ interactive พร้อมบันทึกลง awaken อัตโนมัติ |
| **sw-deploy** | `/sw-deploy` | Deploy โปรเจกต์โดยอ่านและทำตาม `.claude/sw/DEPLOY.md` ทีละขั้นอัตโนมัติ |
| **sw-commit** | `/sw-commit` | วิเคราะห์ git diff แล้วสร้าง Conventional Commit message พร้อม confirm ก่อน commit |
| **sw-check** | `/sw-check` | ตรวจสอบ environment: runtime, git config, package manager, และ .env security |
| **sw-doctor** | `/sw-doctor` | ตรวจสอบ version เทียบกับ marketplace บน GitHub แจ้งเมื่อมี version ใหม่ให้อัปเดต |
| **sw-docs** | `/sw-docs` | แสดงคู่มือการใช้งาน skills ทั้งหมด โดยดึงจาก GitHub สดทุกครั้ง |
| **sw-awaken** | `/sw-awaken` | โหลด awaken knowledge ถาวรของ Claude จาก `.claude/sw/awaken/` |
| **sw-on-session** | `/sw-on-session` | เรียกใช้งานเมื่อเริ่ม session ใหม่ เพื่อ bootstrap context |

---

## 🪝 Default Hooks (สร้างอัตโนมัติโดย sw-init)

| Hook | Event | ทำอะไร |
|------|-------|--------|
| `track-action.sh` | PreToolUse | จับ action ล่าสุดของ Claude (Write, Edit, Bash, git ฯลฯ) |
| `notify-done.sh` | Stop | popup + เสียง + พูดภาษาไทยแจ้งว่าทำอะไรเสร็จ |

---

## 🔄 สำหรับผู้พัฒนา — deploy version ใหม่

เมื่อ deploy version ใหม่ ให้อัปเดต version ใน 3 ไฟล์นี้ให้ตรงกัน:

| ไฟล์ | field |
|------|-------|
| `.claude-plugin/plugin.json` | `"version"` |
| `.claude-plugin/marketplace.json` | `"metadata.version"` และ `"plugins[0].version"` |
| `DOCS.md` | `**Version:**` |
| `CHANGELOG.md` | entry header เช่น `## [YYYY-MM-DD] — vX.X.X` |

จากนั้น commit และ push — marketplace จะดึง version ใหม่จาก GitHub โดยอัตโนมัติ

---

## 👤 Author

**SecWind** — secwind.dev@gmail.com
