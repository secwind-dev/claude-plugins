---
name: sw-doctor
description: 'ตรวจสอบ version ของ sw-claude-plugins เทียบกับ GitHub — ถ้ามี version ใหม่จะ auto-update ให้เลย แล้วแสดง changelog. Usage: /sw-doctor'
disable-model-invocation: true
---


ทำทุกอย่างอัตโนมัติ — ตรวจสอบ → update → แจ้งผล โดยไม่ต้องถาม

---

## ขั้นที่ 1 — หา Local Version และ Plugin Directory

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
  fi
fi

if [ -n "$PLUGIN_JSON" ]; then
  LOCAL_VER=$(jq -r '.version // empty' "$PLUGIN_JSON")
  # ขึ้นไป 2 ระดับจาก .claude-plugin/plugin.json → ได้ root ของ plugin
  PLUGIN_DIR=$(dirname "$(dirname "$PLUGIN_JSON")")
  echo "VERSION:$LOCAL_VER"
  echo "DIR:$PLUGIN_DIR"
else
  echo "NOT_FOUND"
fi
```

- ถ้า `NOT_FOUND` → แจ้ง user:
  ```
  ❌ ไม่พบ sw-claude-plugins ที่ติดตั้งอยู่ค่ะ บอส
  กรุณาติดตั้งก่อนด้วยคำสั่ง:
    /plugin marketplace add secwind-dev/claude-plugins
    /plugin install sw-claude-plugins@sw-plugins
  ```
  แล้วหยุด

- บันทึก `LOCAL_VER` และ `PLUGIN_DIR` ไว้ใช้ต่อ

---

## ขั้นที่ 2 — ดึง Remote Version จาก GitHub

รัน Bash tool:

```bash
curl -sf "https://raw.githubusercontent.com/secwind-dev/claude-plugins/main/.claude-plugin/plugin.json" \
  | jq -r '.version // empty'
```

- ถ้าได้ version → บันทึกเป็น `REMOTE_VER`
- ถ้า output ว่างหรือ fail → แจ้ง user:
  ```
  ❌ ไม่สามารถเชื่อมต่อ GitHub ได้ค่ะ บอส
  กรุณาตรวจสอบ internet connection แล้วลองใหม่นะคะ
  ```
  แล้วหยุด

---

## ขั้นที่ 3 — เปรียบเทียบ Version

รัน Bash tool (แทนที่ `<local>` และ `<remote>` ด้วยค่าจริง):

```bash
LOCAL_VER="<local>"
REMOTE_VER="<remote>"

verlte() {
  [ "$1" = "$(printf '%s\n%s' "$1" "$2" | sort -V | head -n1)" ]
}

if [ "$LOCAL_VER" = "$REMOTE_VER" ]; then
  echo "UP_TO_DATE"
elif verlte "$LOCAL_VER" "$REMOTE_VER"; then
  echo "OUTDATED"
else
  echo "AHEAD"
fi
```

---

## ขั้นที่ 4 — แยก Flow ตามผล

### กรณี `UP_TO_DATE`

แสดงผลทันที:

```
🩺 sw-doctor — ผลการตรวจสอบ

✅ คุณใช้ version ล่าสุดอยู่แล้วค่ะ บอส!

📌 Local  : v<local_version>
🌐 Remote : v<remote_version>

ไม่ต้องทำอะไรเพิ่มเติมนะคะ 🎉
```

หยุด

---

### กรณี `AHEAD` (dev mode)

แสดงผลทันที:

```
🩺 sw-doctor — ผลการตรวจสอบ

🔵 Local version ใหม่กว่า remote ค่ะ บอส (dev mode?)

📌 Local  : v<local_version>
🌐 Remote : v<remote_version>

ดูเหมือน local จะเป็น development version นะคะ ไม่ต้องทำอะไรค่ะ
```

หยุด

---

### กรณี `OUTDATED` → ไปขั้นที่ 5

---

## ขั้นที่ 5 — ดึง Changelog ของ version ใหม่

รัน Bash tool เพื่อดึง CHANGELOG จาก GitHub แล้วกรองเฉพาะ entry ของ version ใหม่:

```bash
REMOTE_VER="<remote_version>"

# ดึง CHANGELOG ทั้งหมด
CHANGELOG=$(curl -sf "https://raw.githubusercontent.com/secwind-dev/claude-plugins/main/CHANGELOG.md")

if [ -z "$CHANGELOG" ]; then
  echo "CHANGELOG_NOT_FOUND"
else
  # ดึงเฉพาะ section ของ version ล่าสุด (ตั้งแต่ header จนถึง --- ถัดไป)
  echo "$CHANGELOG" | awk \
    "/^## \[.*\].*v${REMOTE_VER}[^0-9]/{found=1} found{print; if(/^---/ && NR>1){exit}}" \
    | head -30
fi
```

- ถ้าได้ changelog content → บันทึกไว้
- ถ้า `CHANGELOG_NOT_FOUND` → ใช้ข้อความ "ดู changelog ได้ที่ https://github.com/secwind-dev/claude-plugins"

---

## ขั้นที่ 6 — แสดงผลสรุป

```
🩺 sw-doctor — ผลการตรวจสอบ

⚠️ มี version ใหม่ให้อัปเดตค่ะ บอส!

📌 Local  : v<local_version>
🌐 Remote : v<remote_version>

📋 สิ่งที่เปลี่ยนแปลงใน v<remote_version>:
──────────────────────────────────────
<changelog content ที่ได้จากขั้นที่ 5>
──────────────────────────────────────

🔄 รัน 2 คำสั่งนี้เพื่ออัปเดตนะคะ บอส:

  /plugin marketplace update sw-plugins
  /plugin update sw-claude-plugins@sw-plugins
```
