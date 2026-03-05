---
name: sw-review
description: 'Read git diff and perform code review with feedback, risks, and best practices. Usage: /sw-review [target]'
argument-hint: '[branch/commit หรือเว้นว่างเพื่อ review ทุก uncommitted changes]'
disable-model-invocation: true
---
---

## ขั้นที่ 1 — กำหนด target

argument ที่รับมา: `$ARGUMENTS`

- ถ้ามี argument → ใช้เป็น target เช่น `/sw-review main` → `git diff main`
- ถ้าไม่มี argument → ใช้ `git diff HEAD` (ทุก uncommitted changes ทั้ง staged + unstaged)

---

## ขั้นที่ 2 — ดึง diff

ใช้ Bash รันคำสั่งต่อไปนี้:

```bash
# ถ้ามี argument
git diff <target>

# ถ้าไม่มี argument
git diff HEAD
```

ถ้าผลลัพธ์ว่างเปล่า ให้รัน fallback:

```bash
git diff --cached
```

---

## ขั้นที่ 3 — ตรวจสอบ diff

- ถ้า diff ยังว่างอยู่ → แจ้ง user:

```
ไม่พบการเปลี่ยนแปลงที่จะ review ค่ะ บอส

💡 ลองใช้:
   /sw-review main     — เปรียบเทียบกับ branch main
   /sw-review HEAD~3   — ย้อนกลับ 3 commits
```

แล้วหยุด

---

## ขั้นที่ 4 — วิเคราะห์และแสดงผล Review

อ่าน diff ทั้งหมดแล้ววิเคราะห์อย่างละเอียด จากนั้นแสดงผลในรูปแบบต่อไปนี้:

---

## 📝 Code Review

> 🎯 Target: `<target ที่ใช้>` | 📁 `<จำนวนไฟล์>` ไฟล์ | ➕`<บรรทัดที่เพิ่ม>` ➖`<บรรทัดที่ลบ>`

---

### 📋 สรุปการเปลี่ยนแปลง

[อธิบายภาพรวมว่าโค้ดเปลี่ยนแปลงอะไรบ้าง ใน 3-5 bullet points]

---

### ✅ จุดดี

[สิ่งที่ทำได้ดีในโค้ดนี้ — ถ้าไม่มีให้ข้ามหัวข้อนี้]

---

### ⚠️ จุดเสี่ยง / ปัญหา

[ปัญหาที่พบ พร้อมระบุไฟล์และบรรทัด เรียงลำดับจากรุนแรงมากไปน้อย]

- แต่ละจุดใช้รูปแบบ: `📍 file.ts:NN` — [อธิบายปัญหา]
- ถ้าไม่มีปัญหา → แสดง "✅ ไม่พบจุดเสี่ยง"

---

### 🔒 Security

[ตรวจสอบด้าน security เช่น injection, exposed secrets, insecure dependencies, XSS]

- ถ้าไม่มีความเสี่ยง → แสดง "✅ ไม่พบความเสี่ยงด้าน security"

---

### 💡 Best Practice & คำแนะนำ

[แนะนำการปรับปรุงที่ควรทำ — เน้น actionable]

---

### 🏁 สรุป

| หัวข้อ | ผล |
|--------|-----|
| Code Quality | [⭐⭐⭐⭐⭐ / 5 พร้อมคำอธิบายสั้น] |
| Security | [✅ ปลอดภัย / ⚠️ มีความเสี่ยง / 🚨 Critical] |
| ควร merge? | [✅ พร้อม merge / ⚠️ ควรแก้ก่อน / 🚫 ยังไม่ควร merge] |
