# MEMORY.md

## ความทรงจำ

### รูปแบบการบันทึก

- ต้องอ่านไฟล์นี้ก่อนเสมอ เพื่อ append ต่อ ไม่ใช่เขียนทับ
- จัดกลุ่มเป็นหมวดหมู่ เช่น ข้อมูลส่วนตัว / ความชอบ / งาน / โปรเจกต์
- ถ้าข้อมูลใหม่อัปเดตของเดิม ให้แก้ไขแทนการเพิ่มซ้ำ
- หลังบันทึกให้แจ้ง user ว่าบันทึกแล้ว

<!-- Claude จะ append ข้อมูลที่ต้องจำลงที่นี่ -->

---

## 📋 Skills ที่วางแผนจะสร้าง

> บันทึกเมื่อ 2026-03-03 — นายท่านสนใจสร้างทั้ง 5 skills

| Skill | คำสั่ง | ทำอะไร | Priority |
|-------|--------|--------|----------|
| sw-changelog | `/sw-changelog` | สร้าง CHANGELOG entry อัตโนมัติจาก git log ตั้งแต่ tag ล่าสุด จัดกลุ่มเป็น Added/Fixed/Changed | ⭐⭐⭐ |
| sw-hook | `/sw-hook <hook-name>` | สร้าง Claude Code hook file พร้อม template และลงทะเบียนใน settings.json | ⭐⭐⭐ |
| sw-review | `/sw-review` | อ่าน git diff แล้วทำ code review พร้อม feedback, ชี้จุดเสี่ยง, แนะนำ best practice | ⭐⭐ |
| sw-scaffold | `/sw-scaffold <feature>` | สร้าง file structure ครบชุดสำหรับ feature ใหม่ (main, test, types, index) | ⭐⭐ |
| sw-test | `/sw-test <file>` | Generate unit tests จากไฟล์ที่ระบุ ครอบคลุม edge cases | ⭐ |
