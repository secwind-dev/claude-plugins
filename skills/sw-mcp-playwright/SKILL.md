---
name: sw-mcp-playwright
description: 'Install and configure Playwright MCP server in ~/.claude/settings.json automatically. Enables browser automation, web scraping, screenshot, and PDF capabilities. Usage: /sw-mcp-playwright'
disable-model-invocation: true
---

เรียก user ว่า **บอส** เสมอ

ทำทุกอย่างอัตโนมัติ **ไม่มี AskUserQuestion** — ติดตั้งและ config ครบในคราวเดียว

---

## ขั้นที่ 1 — ตรวจสอบว่าติดตั้งแล้วหรือยัง

ใช้ Bash ตรวจสอบ 2 อย่าง:

```bash
# ตรวจว่า package มีอยู่แล้วไหม
npm list -g @playwright/mcp 2>/dev/null | grep playwright

# ตรวจว่า settings.json มี playwright config แล้วหรือยัง
cat ~/.claude/settings.json 2>/dev/null | grep -i playwright
```

- ถ้า **ติดตั้งแล้วและมี config แล้ว** → แจ้ง user แล้วหยุด:

```
✅ Playwright MCP ติดตั้งและ config ไว้แล้วค่ะ บอส!

💡 ใช้งานได้เลยด้วย:
   เปิดหน้า https://example.com แล้วถ่าย screenshot
   บันทึก https://example.com เป็น PDF ที่ ~/Downloads/page.pdf
```

- ถ้า **ยังไม่ได้ติดตั้ง หรือยังไม่มี config** → ทำต่อขั้นถัดไป

---

## ขั้นที่ 2 — ติดตั้ง @playwright/mcp

```bash
npm install -g @playwright/mcp
```

- ถ้า error → ลอง:

```bash
sudo npm install -g @playwright/mcp
```

---

## ขั้นที่ 3 — ติดตั้ง Playwright browsers

```bash
npx playwright install chromium
```

> ติดตั้งเฉพาะ Chromium เพื่อไม่ให้ใช้พื้นที่มากเกินไป

---

## ขั้นที่ 4 — อ่านและ update ~/.claude/settings.json

อ่านไฟล์ `~/.claude/settings.json` ก่อน

- ถ้า **ไม่มีไฟล์** → สร้างใหม่ด้วย content นี้:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

- ถ้า **มีไฟล์อยู่แล้ว** → อ่านเนื้อหาเดิม แล้ว merge เพิ่ม key `playwright` เข้าไปใน `mcpServers` โดยคงทุก key เดิมไว้:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

> **หมายเหตุ:** ถ้ามี `mcpServers` อยู่แล้วให้ merge เฉพาะ key `playwright` เข้าไป ไม่ใช่ทับทั้ง object

---

## ขั้นที่ 5 — ตรวจสอบผลลัพธ์

```bash
# ยืนยันว่า package ติดตั้งสำเร็จ
npm list -g @playwright/mcp

# แสดง config ที่เพิ่มเข้าไป
cat ~/.claude/settings.json
```

---

## ขั้นที่ 6 — แจ้งผลสรุป

```
✅ ติดตั้ง Playwright MCP เรียบร้อยแล้วค่ะ บอส!

📦 @playwright/mcp    — ติดตั้งสำเร็จ (global)
🌐 Chromium browser   — ติดตั้งสำเร็จ
🔧 ~/.claude/settings.json — เพิ่ม mcpServers.playwright แล้ว

⚠️  รีสตาร์ท Claude Code เพื่อให้ MCP server โหลดใหม่ด้วยนะคะ บอส

💡 หลัง restart ใช้งานได้เลย เช่น:
   เปิดหน้า https://example.com แล้วถ่าย screenshot
   บันทึก https://example.com เป็น PDF ที่ ~/Downloads/page.pdf
   เข้า URL นี้แล้วดึงข้อมูลทั้งหมดออกมา: https://...
```
