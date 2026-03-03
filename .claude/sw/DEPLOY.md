# DEPLOY.md

## คู่มือ Deploy สำหรับ Claude

เมื่อได้รับคำสั่ง `deploy` ให้ทำตามขั้นตอนด้านล่างทีละขั้น ห้ามข้ามขั้นตอน

---

### ขั้นที่ 1 — นำเสนอ commit ให้ user confirm

แสดงรายการไฟล์ที่จะ commit (git status) พร้อม commit message ที่จะใช้ แล้ว **รอ confirm จาก user ก่อน**

### ขั้นที่ 2 — ถ้าได้รับการ confirm ให้อัปเดต version และ CHANGELOG ก่อน

- อัปเดต Version ใน .claude-plugin/plugin.json
- สร้าง/อัปเดต ./CHANGELOG.md

### ขั้นที่ 3 — commit และ push ต่อเนื่องทันที

```bash
git add .
git commit -m "..."
git push
```

### ⚠️ กฎสำคัญ

- ถามแค่ครั้งเดียวก่อน commit — ถ้า confirm แล้วให้ push ต่อเลยโดยไม่ต้องถามอีก
- หลัง git push สำเร็จให้บันทึกลง CHANGELOG.md ด้วย
