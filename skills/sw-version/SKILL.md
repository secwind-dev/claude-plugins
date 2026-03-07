---
name: sw-version
description: 'แสดง version ของ sw-claude-plugins ที่ติดตั้งอยู่. Usage: /sw-version'
disable-model-invocation: true
---

แสดง version ของ sw-claude-plugins อัตโนมัติ — ไม่ต้องถาม

---

## ขั้นที่ 1 — หา Plugin Version

รัน Bash tool:

```bash
# ค้นหา plugin.json ของ sw-claude-plugins จาก installed path
PLUGIN_JSON=$(find ~/.claude/plugins -name "plugin.json" 2>/dev/null \
  | xargs grep -l '"sw-claude-plugins"' 2>/dev/null \
  | head -1)

# fallback: dev mode (รันจาก repo โดยตรง)
if [ -z "$PLUGIN_JSON" ]; then
  DEV_PATH=".claude-plugin/plugin.json"
  if [ -f "$DEV_PATH" ] && grep -q '"sw-claude-plugins"' "$DEV_PATH" 2>/dev/null; then
    PLUGIN_JSON="$DEV_PATH"
    IS_DEV=true
  fi
fi

if [ -n "$PLUGIN_JSON" ]; then
  VERSION=$(jq -r '.version // empty' "$PLUGIN_JSON")
  NAME=$(jq -r '.name // empty' "$PLUGIN_JSON")
  AUTHOR=$(jq -r '.author.name // empty' "$PLUGIN_JSON")
  echo "VERSION:$VERSION"
  echo "NAME:$NAME"
  echo "AUTHOR:$AUTHOR"
  echo "DEV:${IS_DEV:-false}"
else
  echo "NOT_FOUND"
fi
```

- ถ้าผลลัพธ์เป็น `NOT_FOUND` → แจ้ง user:
  ```
  ❌ ไม่พบ sw-claude-plugins ที่ติดตั้งอยู่ค่ะ บอส
  กรุณาติดตั้งก่อนด้วยคำสั่ง:
    /plugin marketplace add secwind-dev/claude-plugins
    /plugin install sw-claude-plugins@sw-plugins
  ```
  แล้วหยุด

- บันทึก `VERSION`, `NAME`, `AUTHOR`, `DEV` ไว้ใช้ต่อ

---

## ขั้นที่ 2 — แสดงผล

กรณีปกติ (DEV=false):

```
📦 sw-claude-plugins

🔖 Version : v<version>
👤 Author  : <author>

💡 ใช้ /sw-doctor เพื่อเช็คอัปเดตนะคะ
```

กรณี dev mode (DEV=true):

```
📦 sw-claude-plugins

🔖 Version : v<version> (dev)
👤 Author  : <author>

⚙️ รันอยู่ใน development mode ค่ะ บอส
```
