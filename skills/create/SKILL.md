---
name: create
description: Creates a file at the given path, including any parent directories. Usage: /create <path> (e.g. /create service/data.ts)
argument-hint: <path/to/file.ext>
disable-model-invocation: true
---

path ที่รับมา: `$ARGUMENTS`

ทำตามขั้นตอนต่อไปนี้:

## ขั้นที่ 1 — แยก directory และ filename

จาก path `$ARGUMENTS` ให้แยก:
- **dir** = ส่วนที่เป็น folder ทั้งหมด (ทุกอย่างก่อน `/` สุดท้าย)
- **filename** = ส่วนที่เป็นชื่อไฟล์ (หลัง `/` สุดท้าย)
- **ext** = นามสกุลไฟล์ (หลัง `.` สุดท้าย)

## ขั้นที่ 2 — สร้าง directory

ถ้า **dir** ไม่ว่าง ให้ใช้ Bash รัน:

```bash
mkdir -p <dir>
```

## ขั้นที่ 3 — สร้างไฟล์ด้วย boilerplate ตาม extension

ใช้ tool `Write` สร้างไฟล์ที่ `$ARGUMENTS` โดยใส่ boilerplate ตาม **ext**:

### `.ts` / `.tsx`
```ts
// $ARGUMENTS
```

### `.js` / `.jsx`
```js
// $ARGUMENTS
```

### `.py`
```python
# $ARGUMENTS
```

### `.md`
```markdown
# <filename ไม่มี extension>
```

### `.json`
```json
{}
```

### `.css` / `.scss`
```css
/* $ARGUMENTS */
```

### `.html`
```html
<!DOCTYPE html>
<html lang="th">
  <head>
    <meta charset="UTF-8" />
    <title><filename></title>
  </head>
  <body></body>
</html>
```

### นามสกุลอื่นๆ หรือไม่มีนามสกุล
สร้างไฟล์เปล่า (empty string)

## ขั้นที่ 4 — แจ้งผล

```
✅ สร้างไฟล์เรียบร้อย

📄 $ARGUMENTS
```

ถ้ามีการสร้าง directory ใหม่ ให้แสดงเพิ่ม:

```
📁 สร้าง folder: <dir>
```
