---
name: sw-yt
description: 'สรุปเนื้อหา YouTube video จาก URL โดยใช้ subtitle/transcript. Usage: /sw-yt <youtube-url> [--create=<folder>]'
argument-hint: '<youtube-url> [--create=<folder>]'
disable-model-invocation: true
---

argument ที่รับมา: `$ARGUMENTS`

---

## ขั้นที่ 0 — รับและตรวจสอบ Arguments

Parse arguments จาก `$ARGUMENTS`:
- แยก `--create=<folder>` ออกจาก arguments → บันทึกค่า folder ไว้เป็น **save_folder** (ถ้าไม่มี flag นี้ ค่าเป็น `null`)
- ส่วนที่เหลือ (ที่ไม่ใช่ `--create=...`) คือ URL → บันทึกไว้เป็น **youtube_url**

ตรวจว่า **youtube_url** ขึ้นต้นด้วย `https://www.youtube.com` หรือ `https://youtu.be` หรือไม่:
- ถ้าไม่มี URL → แจ้ง user:
  ```
  ❌ กรุณาระบุ YouTube URL ค่ะ บอส

  ตัวอย่าง:
    /sw-yt https://www.youtube.com/watch?v=xxxxx
    /sw-yt https://youtu.be/xxxxx
    /sw-yt https://www.youtube.com/watch?v=xxxxx --create=.test
  ```
  แล้วหยุด

---

## ขั้นที่ 1 — ตรวจสอบ yt-dlp

รัน Bash tool:

```bash
which yt-dlp && yt-dlp --version || echo "NOT_FOUND"
```

- ถ้าผลลัพธ์เป็น `NOT_FOUND` → แจ้ง user:
  ```
  ❌ ไม่พบ yt-dlp ในระบบค่ะ บอส

  กรุณาติดตั้งก่อน:
    brew install yt-dlp        # macOS
    pip install yt-dlp         # pip
    sudo apt install yt-dlp    # Ubuntu/Debian
  ```
  แล้วหยุด

---

## ขั้นที่ 2 — ดึง Subtitle และข้อมูล Video จาก YouTube

รัน Bash tool:

```bash
mkdir -p /tmp/sw-yt-cache && \
yt-dlp \
  --write-auto-sub \
  --sub-lang th,en \
  --sub-format vtt \
  --skip-download \
  --no-playlist \
  --print "%(id)s|||%(title)s|||%(uploader)s|||%(duration_string)s" \
  -o "/tmp/sw-yt-cache/%(id)s.%(ext)s" \
  "<youtube_url>" 2>&1
```

- ตรวจสอบผลลัพธ์:
  - ถ้ามี error `Video unavailable` หรือ `Private video` → แจ้ง user ว่าคลิปไม่สามารถเข้าถึงได้แล้วหยุด
  - ถ้ามี error `no subtitles` หรือไม่พบไฟล์ `.vtt` → ไปที่ **ขั้นที่ 2.1**
  - ถ้าสำเร็จและพบไฟล์ `.vtt` → ไปที่ **ขั้นที่ 3**

- จาก output บรรทัดที่มีรูปแบบ `<ID>|||<title>|||<uploader>|||<duration>` → แยกด้วย `|||` แล้วบันทึก:
  - **video_id** = ส่วนแรก (11 ตัวอักษร pattern `[A-Za-z0-9_-]`)
  - **title**, **channel**, **duration** = ส่วนที่เหลือ

---

## ขั้นที่ 2.1 — ไม่พบ Subtitle

แจ้ง user:

```
⚠️ ไม่พบ subtitle สำหรับคลิปนี้ค่ะ บอส

คลิปนี้อาจ:
- ปิด subtitle ทั้งหมด
- เป็นคลิปที่ YouTube ยังไม่ generate auto-caption ให้
- เป็นคลิปสั้นที่ไม่มี transcript

💡 ทางเลือก: คัดลอก transcript จาก YouTube แล้ว paste มาให้สรุปได้เลยค่ะ
   (กด ··· ใต้วิดีโอ → "Show transcript")
```

แล้วหยุด

---

## ขั้นที่ 3 — หาและอ่านไฟล์ Subtitle

รัน Bash tool เพื่อหาไฟล์ที่ดาวน์โหลดมา:

```bash
find /tmp/sw-yt-cache -name "<video_id>*.vtt" 2>/dev/null || echo "NOT_FOUND"
```

- ถ้าพบไฟล์หลายตัว → เลือก `.th.vtt` ก่อน ถ้าไม่มีใช้ `.en.vtt`
- บันทึก path ไว้เป็น **vtt_file**

รัน Bash tool เพื่อดึงข้อความจาก VTT:

```bash
python3 << 'PYEOF'
import re

with open("<vtt_file>", "r", encoding="utf-8") as f:
    text = f.read()

lines = text.split('\n')
clean = []
for line in lines:
    if re.match(r'^\d{2}:\d{2}', line): continue
    if re.match(r'^WEBVTT', line): continue
    if re.match(r'^NOTE', line): continue
    if re.match(r'^Kind:', line): continue
    if re.match(r'^Language:', line): continue
    if line.strip() == '': continue
    line = re.sub(r'<[^>]+>', '', line)
    if line.strip():
        clean.append(line.strip())

# ลบบรรทัดซ้ำติดกัน
deduped = [clean[0]] if clean else []
for line in clean[1:]:
    if line != deduped[-1]:
        deduped.append(line)

print(' '.join(deduped))
PYEOF
```

- บันทึกข้อความที่ได้ไว้เป็น **transcript**

---

## ขั้นที่ 4 — สรุปเนื้อหา

อ่าน **transcript** ที่ได้มา แล้วสรุปเป็นภาษาไทยในรูปแบบนี้ และบันทึก content ทั้งหมดไว้เป็น **summary_content**:

```
🎬 <title>
📺 <channel>  ⏱ <duration>

---

## สรุปภาพรวม
<สรุปว่าคลิปนี้พูดถึงอะไร ใน 2-3 ประโยค>

## ประเด็นหลัก
<bullet points สรุปเนื้อหาสำคัญ จัดเป็นหัวข้อย่อยถ้าเหมาะสม>

## สรุปสั้น
<ประโยคเดียวที่บอกว่าคลิปนี้มีประโยชน์กับใคร>

---
🔤 Subtitle: <th หรือ en>
🔗 <youtube_url>
```

แสดง **summary_content** ให้ user เห็นทันที แล้วไปที่ **ขั้นที่ 5**

---

## ขั้นที่ 5 — บันทึกไฟล์ (ถ้ามี --create)

ถ้า **save_folder** ไม่ใช่ `null`:

1. กำหนดชื่อไฟล์จาก **title** — แปลงเป็น slug (lowercase, แทนที่ space และอักขระพิเศษด้วย `-`, ตัดให้สั้น ≤ 60 ตัวอักษร) แล้วเติม `.md` → บันทึกไว้เป็น **filename**

2. รัน Bash tool สร้าง folder:
   ```bash
   mkdir -p "<save_folder>"
   ```

3. ใช้ Write tool บันทึก **summary_content** ลงไฟล์ที่ `<save_folder>/<filename>`

4. แจ้ง user:
   ```
   💾 บันทึกไฟล์สำเร็จแล้วค่ะ บอส
      📄 <save_folder>/<filename>
   ```

---

## ขั้นที่ 6 — ล้าง Cache

รัน Bash tool:

```bash
rm -f /tmp/sw-yt-cache/<video_id>*.vtt
```
