# DEPLOY.md

## คู่มือ Deploy สำหรับ Claude

เมื่อได้รับคำสั่ง `deploy` ให้ทำตามขั้นตอนด้านล่างทีละขั้น ห้ามข้ามขั้นตอน

---

### ขั้นที่ 1 — สร้าง git commit

```bash
git add .
git commit -m "feat: ..."
```

### ขั้นที่ 2 — นำเสนอ commit ที่สร้างให้ user confirm

### ขั้นที่ 3 — ถ้าได้รับการ confirm ถึงจะทำการ git push ต่อไป

```bash
git push
```

### ขั้นที่ 4 — อัปเดตข้อมูล

- อัปเดต Version ใน .claude-plugin/plugin.json อัตโนมัติ
- สร้าง/อัปเดต ./CHANGELOG.md อัตโนมัติ

### ⚠️ กฎสำคัญ

- ขั้นที่ 1 ต้องได้รับอนุญาตจาก user ก่อนเสมอ
- หลัง git push สำเร็จให้บันทึกลง CHANGELOG.md ด้วย
