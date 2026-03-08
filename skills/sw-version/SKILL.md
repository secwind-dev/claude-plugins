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
INSTALLED_JSON=~/.claude/plugins/installed_plugins.json

# อ่าน installPath ของ sw-claude-plugins จาก installed_plugins.json (source of truth)
# เลือก scope "user" ก่อน ถ้าไม่มีค่อย fallback ไป scope แรกที่เจอ
if [ -f "$INSTALLED_JSON" ]; then
  INSTALL_PATH=$(jq -r '
    (.plugins["sw-claude-plugins@sw-plugins"] // [])
    | (map(select(.scope == "user"))[0] // .[0])
    | .installPath // empty
  ' "$INSTALLED_JSON")
fi

# ถ้าเจอ installPath → ใช้ plugin.json จาก path นั้น
if [ -n "$INSTALL_PATH" ]; then
  PLUGIN_JSON="$INSTALL_PATH/.claude-plugin/plugin.json"
fi

# fallback: dev mode (รันจาก repo โดยตรง)
if [ -z "$PLUGIN_JSON" ] || [ ! -f "$PLUGIN_JSON" ]; then
  DEV_PATH=".claude-plugin/plugin.json"
  if [ -f "$DEV_PATH" ] && grep -q '"sw-claude-plugins"' "$DEV_PATH" 2>/dev/null; then
    PLUGIN_JSON="$DEV_PATH"
    IS_DEV=true
  fi
fi

if [ -n "$PLUGIN_JSON" ] && [ -f "$PLUGIN_JSON" ]; then
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
