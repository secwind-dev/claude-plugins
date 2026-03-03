# PACKAGES.md

## Dependencies (ใช้งาน production)

| Package | Version | คำสั่งที่ใช้ | วัตถุประสงค์ |
| ------- | ------- | ------------ | ------------ |

## DevDependencies (ใช้เฉพาะ development)

| Package         | Version | คำสั่งที่ใช้                   | วัตถุประสงค์                    |
| --------------- | ------- | ------------------------------ | ------------------------------- |
| @changesets/cli | -       | npm install -D @changesets/cli | จัดการ versioning และ changelog |

## 🔖 กฎการบันทึก

- บันทึกทันทีหลัง install ห้ามรอ
- ดู version จริงจาก package.json เสมอ ไม่เดาเอง
- แยก Dependencies และ DevDependencies ให้ชัดเจน
- ถ้า uninstall → ลบแถวออกและบันทึกใน CHANGELOG.md ด้วย

## 📌 หมายเหตุ

- รัน `npx changeset init` หลัง install @changesets/cli
