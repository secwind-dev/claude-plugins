---
name: sw-adc
description: 'แปลง code หรือสร้าง code ใหม่ใน ADC style (ci, ciTag, Tag pattern) โดยอ้างอิง .claude/sw/ADC.md. รับได้ทั้ง code โดยตรง หรือคำสั่งภาษาไทย/อังกฤษ Usage: /sw-adc <code หรือคำสั่ง>'
argument-hint: '<code หรือคำสั่ง เช่น "const result = fn3(fn2(fn1(x)))" หรือ "สร้าง function getIncludeVat">'
disable-model-invocation: true
---

---

## ขั้นที่ 0 — รับ Argument และตรวจสอบโหมด

argument ที่รับมา: `$ARGUMENTS`

- ถ้าไม่มี argument เลย → แจ้ง user:

```
กรุณาวาง code หรือบอกสิ่งที่ต้องการด้วยนะคะ บอส

Usage: /sw-adc <code หรือคำสั่ง>
ตัวอย่าง (โหมดแปลง code):
  /sw-adc const result = fn3(fn2(fn1(data)))
  /sw-adc if (err) return err; const x = doA(data); const y = doB(x); return y;
  /sw-adc [วาง code หลายบรรทัดได้เลยค่ะ]

ตัวอย่าง (โหมดสร้าง code):
  /sw-adc สร้าง function getIncludeVat
  /sw-adc เขียน function validate email แล้วคืน Tag
  /sw-adc create a pipe that fetches user data and filters active ones
```

แล้วหยุด

### ตรวจสอบโหมด

วิเคราะห์ argument ที่รับมาว่าเป็น **โหมดใด**:

| โหมด           | ลักษณะ argument                                                                                   | ขั้นตอนถัดไป                    |
| -------------- | ------------------------------------------------------------------------------------------------- | ------------------------------- |
| **แปลง code**  | มี syntax ของ code จริง เช่น `const`, `function`, `=>`, `{}`, `()`, `;` เด่นชัด                   | ไปขั้นที่ 1 → 2 → 3 → 4 ตามปกติ |
| **สร้าง code** | เป็นคำสั่ง / คำอธิบาย เช่น "สร้าง", "เขียน", "create", "make", "generate", หรือชื่อ function โดดๆ | ไปขั้นที่ 1 → 2G → 3G → 4       |

> หากไม่แน่ใจ → เลือกโหมด **สร้าง code** ไว้ก่อน

---

## ขั้นที่ 1 — โหลด ADC.md

ใช้ Read tool อ่านไฟล์ `.claude/sw/ADC.md`

- ถ้าพบไฟล์ → โหลดเนื้อหาแล้วไปขั้นถัดไปได้เลย
- ถ้าไม่พบไฟล์ → ดำเนินการตามขั้นตอนต่อไปนี้:

### 1.1 — Fetch จาก GitHub

ใช้ WebFetch tool ดึงข้อมูลจาก:

```
https://raw.githubusercontent.com/app-adc/adc-directive/main/ADC.md
```

- ถ้า fetch สำเร็จ → ไปขั้น 1.2
- ถ้า fetch ล้มเหลว → แจ้ง user:

```
ไม่พบไฟล์ .claude/sw/ADC.md และไม่สามารถ fetch จาก GitHub ได้ค่ะ บอส
กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต หรือสร้างไฟล์ .claude/sw/ADC.md ด้วยตนเองนะคะ
```

แล้วหยุด

### 1.2 — บันทึกเป็น local file

ใช้ Write tool บันทึกเนื้อหาที่ fetch มาลงที่ `.claude/sw/ADC.md` แล้วดำเนินการต่อไปยังขั้นถัดไปได้เลย ไม่ต้องแจ้ง user

---

## ขั้นที่ 2G — วิเคราะห์คำสั่ง (โหมดสร้าง code เท่านั้น)

> ข้ามขั้นนี้ถ้าเป็นโหมดแปลง code

อ่านคำสั่งจาก argument แล้ววิเคราะห์:

1. **ชื่อ / วัตถุประสงค์ของ function หรือ module** — ต้องการทำอะไร
2. **Input / Output** — รับอะไร คืนอะไร (ถ้าระบุ)
3. **Error handling** — มี validation หรือ early return ไหม
4. **ADC patterns ที่น่าใช้** — พิจารณาจากลักษณะงาน

| ลักษณะงาน              | ADC pattern ที่แนะนำ             |
| ---------------------- | -------------------------------- |
| ประมวลผลข้อมูลหลายขั้น | `ci`                             |
| Validate + transform   | `ciTag` + `makeTag`              |
| ดึงค่าจาก result       | `fold`                           |
| จัดการ collection      | `sortBy`, `uniqueBy`, `mapArray` |
| Async / delay          | `delayPromise`                   |

---

## ขั้นที่ 3G — สร้าง code (โหมดสร้าง code เท่านั้น)

> ข้ามขั้นนี้ถ้าเป็นโหมดแปลง code

สร้าง code ใน ADC style ตามที่วิเคราะห์ไว้ โดยยึดหลักการต่อไปนี้:

- **Pure function** — ไม่ mutate state ภายนอก
- **ใช้ ADC patterns** ที่เหมาะสมตามขั้นที่ 2G
- **Comment ภาษาไทย** — อธิบาย ADC pattern ที่ใช้
- **ตั้งชื่อให้สื่อความหมาย** — ตามชื่อที่บอสระบุ หรือตั้งให้เหมาะสม
- **ไม่เดา logic** — ถ้า argument ไม่ระบุรายละเอียด → สร้างโครงสร้างหลักพร้อม TODO comment

จากนั้นแสดงผลด้วย format เดียวกับขั้นที่ 4 (แต่ใช้หัว `✨ ADC Style Generation` แทน `🔄 ADC Style Conversion`)

---

## ขั้นที่ 2 — วิเคราะห์ code

อ่าน code ที่รับมาแล้ววิเคราะห์หาจุดที่ควรแปลงเป็น ADC style โดยใช้ตารางนี้เป็น checklist:

| พบใน code                                         | แปลงเป็น ADC pattern                  |
| ------------------------------------------------- | ------------------------------------- |
| `fn3(fn2(fn1(x)))` — nested calls                 | `ci(x, fn1, fn2, fn3)`                |
| `fn2(fn1(...args))` ที่ initial call มีหลาย arg   | `withCi(fn1, fn2)(...args)`           |
| `try/catch` ใน business logic                     | `ciTag` + `left`/`right`              |
| `if (!valid) return errorMsg` ซ้อนหลายชั้น        | `makeTag(error, predicate)` + `ciTag` |
| `if (result.tag === 'left')` / pattern match Tag  | `fold(onLeft, onRight)`               |
| `arr.sort(fn)` (mutate)                           | `sortBy(arr, fn)`                     |
| `[...new Set(arr.map(fn))]`                       | `uniqueBy(arr, fn)`                   |
| `JSON.parse(JSON.stringify(obj))`                 | `copyDeep(obj)`                       |
| `Object.assign({}, a, b)` deep nested             | `mergeObject(a, b)`                   |
| loop เพื่อ flatten nested array                   | `mapArray(arr)`                       |
| array slice ทำ chunks                             | `chunkArray(arr, n)`                  |
| `for (let i = start; i <= end; i++)`              | `runProcess(items, cb, start, end)`   |
| `new Promise(resolve => setTimeout(resolve, ms))` | `delayPromise(ms, callback)`          |

บันทึกทุกจุดที่พบไว้สำหรับขั้นถัดไป

---

## ขั้นที่ 3 — แปลง code

แปลง code ตามที่วิเคราะห์ไว้ในขั้นที่ 2 โดยยึดหลักการต่อไปนี้:

### หลักการทั่วไป (เหมือน REFACTOR.md)

- **อ่านก่อนแก้** — เข้าใจ intent ของ code เดิมก่อนเสมอ
- **ไม่เปลี่ยน behavior** — ผลลัพธ์ต้องเหมือนเดิม เว้นแต่บอสขอ
- **เปลี่ยนน้อยที่สุด** — แก้เฉพาะที่ pattern ตรงกัน ไม่ over-engineer
- **ตั้งชื่อให้ชัดเจน** — ถ้าต้องเพิ่ม helper function ให้ตั้งชื่อสื่อความหมาย
- **Comment ภาษาไทย** — อธิบาย ADC pattern ที่ใช้ไว้ให้เข้าใจ

### หลักการ ADC (จาก ADC.md)

- ใช้ `ci` แทน nested function calls ที่มี 3 ขั้นขึ้นไป
- ใช้ `ciTag` + `makeTag` แทน guard clauses / early return หลายชั้น
- ใช้ `fold` เพื่อดึงค่าออกจาก Tag แทนการ check `.tag === 'left'`
- ใช้ utility functions (`sortBy`, `uniqueBy`, `copyDeep`, `mergeObject`) แทน custom implementation
- ทุก function ต้อง pure — ถ้า code เดิม mutate state ให้แจ้งบอสก่อน ไม่แก้เอง

### กรณีที่ไม่ควรแปลง

- function ที่มีขั้นตอนน้อยกว่า 3 (ไม่คุ้มกับ `ci`)
- side effect ที่จำเป็น เช่น logging, DOM manipulation, API call — ให้คง `try/catch` ไว้
- code ที่ logic ไม่ชัดเจน → แจ้งบอสแทน ไม่เดา

---

## ขั้นที่ 4 — แสดงผล

แสดงผลในรูปแบบนี้:

**โหมดแปลง code:**

```
🔄 ADC Style Conversion
════════════════════════════════════════
📥 Input  : [สรุป code ที่รับมาแบบสั้น เช่น "nested function calls 4 ขั้น"]
📦 Patterns: [ADC patterns ที่ใช้ เช่น "ci, makeTag, ciTag"]
════════════════════════════════════════
```

**โหมดสร้าง code:**

```
✨ ADC Style Generation
════════════════════════════════════════
📝 คำสั่ง : [สรุปคำสั่งที่รับมา เช่น "สร้าง function getIncludeVat"]
📦 Patterns: [ADC patterns ที่ใช้ เช่น "ci, ciTag"]
════════════════════════════════════════
```

จากนั้นแสดง **ทีละจุด** ในรูปแบบ:

````
📍 [ชื่อการเปลี่ยนแปลง เช่น "แปลง nested calls → ci"]

**ก่อน:**
```[ภาษา]
[code เดิม]
```

**หลัง:**
```[ภาษา]
[code ที่แปลงแล้ว พร้อม comment ภาษาไทยอธิบาย pattern]
```

💡 [อธิบายสั้นๆ ว่าทำไมถึงใช้ pattern นี้]
````

ถ้ามีหลายจุด ให้แสดงทีละจุดตามลำดับ

---

จากนั้นแสดงสรุปท้าย:

````
════════════════════════════════════════
✅ Code ที่แปลงแล้วทั้งหมด:

```[ภาษา]
[full code ที่แปลงแล้วทั้งชิ้น]
```

⏭️ ไม่ได้แปลง (เหตุผล):
  - [สิ่งที่พบแต่ไม่แปลง พร้อมเหตุผล — ถ้ามี]

📦 Import ที่ต้องเพิ่ม:
  import { [functions ที่ใช้] } from 'adc-directive'
  [ถ้าไม่ต้องเพิ่ม → แสดง "—"]
════════════════════════════════════════
````

ถ้าไม่มีอะไรต้องแปลงเลย (โหมดแปลง code):

```
════════════════════════════════════════
✅ Code นี้เขียนใน ADC style แล้วค่ะ บอส ไม่มีอะไรต้องแปลงเพิ่มเลยค่ะ
════════════════════════════════════════
```

ถ้าคำสั่งไม่ชัดเจนพอ (โหมดสร้าง code):

```
════════════════════════════════════════
⚠️ คำสั่งยังไม่ชัดเจนพอค่ะ บอส กรุณาระบุเพิ่มเติม:
  - ชื่อ function ที่ต้องการ
  - Input / Output ที่คาดหวัง
  - มี error handling ไหม
════════════════════════════════════════
```
