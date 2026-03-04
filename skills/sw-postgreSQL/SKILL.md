---
name: sw-postgreSQL
description: 'Setup PostgreSQL สำหรับโปรเจกต์. ตรวจสอบ .claude/sw/POSTGRES_DB.md, สร้าง config ถ้าไม่มี, และ setup Docker container. Usage: /sw-postgreSQL'
disable-model-invocation: true
---

# sw-postgreSQL Skill

## บทบาท
ช่วย setup PostgreSQL ผ่าน Docker สำหรับ local development
ตรวจสอบ config ที่มีอยู่ → ถ้าไม่มีให้สร้างใหม่ → ถามเรื่อง Docker install

---

## ขั้นที่ 1 — ตรวจสอบ POSTGRES_DB.md

รัน Bash tool:
```bash
test -f .claude/sw/POSTGRES_DB.md && echo "EXISTS" || echo "NOT_FOUND"
```

- **EXISTS** → ใช้ Read tool อ่านเนื้อหาแล้วแสดงให้ user เห็น → ข้ามขั้นที่ 2 ไปขั้นที่ 3
- **NOT_FOUND** → แจ้ง user ว่าไม่มี config → ไปขั้นที่ 2

---

## ขั้นที่ 2 — เก็บข้อมูล Config (เฉพาะกรณีไม่มีไฟล์)

ใช้ `AskUserQuestion` tool ถาม **4 ข้อพร้อมกัน**:

1. **Container name** — header: "Container Name", options: `postgres-local` (Recommended), `postgres-dev`, `postgres-app`
2. **Database name** — header: "Database Name", options: `mydb` (Recommended), `appdb`, `devdb`
3. **Port** — header: "Port", options: `5432` (Recommended), `5433`, `5434`
4. **PostgreSQL version** — header: "PG Version", options: `16` (Recommended), `15`, `14`, `latest`

**Credentials ใช้ค่า fixed (dev-only defaults — ไม่ถาม user):**
- Username: `root`
- Password: `password`

หลังได้คำตอบแล้ว → ใช้ Write tool สร้าง `.claude/sw/POSTGRES_DB.md`:

```md
# POSTGRES_DB.md

## PostgreSQL Configuration
- **Container Name:** <container_name>
- **Image:** postgres:<version>
- **Port:** <port>:5432
- **Database:** <dbname>
- **Username:** root
- **Password:** password

## Docker Command (Reference)
docker run -d \
  --name <container_name> \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_USER=root \
  -e POSTGRES_DB=<dbname> \
  -p <port>:5432 \
  postgres:<version>

## Connection String
postgresql://root:password@localhost:<port>/<dbname>

## ⚠️ หมายเหตุ
ไฟล์นี้เป็น local dev config เท่านั้น — ควร add ใน .gitignore
```

หลังสร้างไฟล์แล้ว → append `.claude/sw/POSTGRES_DB.md` เข้า `.gitignore` อัตโนมัติ (ถ้ายังไม่มี):

```bash
grep -qxF '.claude/sw/POSTGRES_DB.md' .gitignore 2>/dev/null || echo '.claude/sw/POSTGRES_DB.md' >> .gitignore
```

แจ้ง user ว่าสร้างไฟล์เรียบร้อยแล้ว และ `.claude/sw/POSTGRES_DB.md` ถูก add ใน `.gitignore` แล้ว

---

## ขั้นที่ 3 — ถามเรื่อง Docker Install

ใช้ `AskUserQuestion` tool ถาม 1 ข้อ:

- **question:** "ต้องการ setup PostgreSQL ผ่าน Docker ตอนนี้เลยไหมคะ บอส?"
- **header:** "Docker Setup"
- **options:**
  - `ใช่เลยค่ะ` — description: "ตรวจสอบ image/container และ setup ทันที"
  - `ยังไม่ตอนนี้` — description: "ข้ามขั้นตอน Docker setup → สรุปผลและจบ"

- **ใช่เลยค่ะ** → ไปขั้นที่ 4
- **ยังไม่ตอนนี้** → สรุปผล: แสดง connection string, แจ้งขั้นตอน setup ในภายหลัง → จบ

---

## ขั้นที่ 4 — ตรวจสอบ Docker Status

รัน 3 Bash commands (ใช้ค่า container_name จาก POSTGRES_DB.md):

```bash
# 1. ตรวจสอบ Docker daemon
docker info > /dev/null 2>&1 && echo "DOCKER_OK" || echo "DOCKER_NOT_RUNNING"
```

```bash
# 2. ตรวจสอบ image ที่มีอยู่
docker images postgres --format "{{.Repository}}:{{.Tag}}" 2>/dev/null
```

```bash
# 3. ตรวจสอบ container status
docker ps -a --filter "name=<container_name>" --format "{{.Names}}\t{{.Status}}" 2>/dev/null
```

**Decision tree ตามผลที่ได้:**

| สถานะ | การดำเนินการ |
|-------|------------|
| `DOCKER_NOT_RUNNING` | แจ้ง user: "กรุณาเปิด Docker Desktop ก่อนนะคะ บอส" → หยุด |
| Container กำลัง running | แจ้ง: "Container `<name>` รันอยู่แล้วค่ะ ✅" → จบ |
| Container หยุดอยู่ (Exited) | ถาม user: "start container เลยไหมคะ?" → ถ้าใช่ → `docker start <name>` → verify → จบ |
| Image มี แต่ไม่มี container | ข้าม pull → ไปขั้นที่ 5 (สร้าง container) |
| ไม่มีทั้ง image และ container | ไปขั้นที่ 5 (pull + สร้าง container) |

---

## ขั้นที่ 5 — Setup Container

ก่อน `docker run` → ใช้ `AskUserQuestion` แจ้ง user:
- **question:** "อิงโกะจะรัน docker run ด้วย password=`password` (dev default) นะคะ บอส — ยืนยันได้เลยไหมคะ? (password นี้จะไม่ถูกบันทึกใน session)"
- **header:** "ยืนยัน Setup"
- **options:**
  - `ยืนยัน` — description: "รัน docker run ทันที"
  - `ยกเลิก` — description: "ยกเลิกการ setup"

ถ้า user ยืนยัน → รัน commands ตามลำดับที่จำเป็น:

```bash
# Pull image (เฉพาะกรณีไม่มี image)
docker pull postgres:<version>
```

```bash
# Create + Start container
docker run -d \
  --name <container_name> \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_USER=root \
  -e POSTGRES_DB=<dbname> \
  -p <port>:5432 \
  postgres:<version>
```

```bash
# Start container (เฉพาะกรณี container หยุดอยู่)
docker start <container_name>
```

หลัง setup เสร็จ → verify ด้วย:
```bash
docker ps --filter "name=<container_name>" --format "{{.Names}}\t{{.Status}}"
```

สรุปผลให้ user เห็น:
- ✅ Container running
- Connection string: `postgresql://root:password@localhost:<port>/<dbname>`
- แจ้งเตือน: ไฟล์ `.claude/sw/POSTGRES_DB.md` เป็น local dev config — ควร add ใน `.gitignore`

---

## ข้อควรระวัง
- Username/Password เป็น fixed dev defaults (`root`/`password`) — เหมาะสำหรับ local dev เท่านั้น
- POSTGRES_DB.md ควร add ใน `.gitignore` เสมอ
- ถ้า Docker ไม่รัน → หยุดและแจ้ง user ก่อน ห้าม proceed ต่อ
