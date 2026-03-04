---
name: sw-postgreSQL
description: 'Setup PostgreSQL สำหรับโปรเจกต์. สร้าง docker-compose.yml + .env สำหรับ local dev. Usage: /sw-postgreSQL'
disable-model-invocation: true
---

# sw-postgreSQL Skill

## บทบาท
ช่วย setup PostgreSQL ผ่าน Docker Compose สำหรับ local development
สร้าง `docker-compose.yml` (commit ได้) + `.env` (gitignored) แยกกัน

---

## ขั้นที่ 1 — ตรวจสอบ Config ที่มีอยู่

รัน Bash tool:
```bash
test -f docker-compose.yml && echo "EXISTS" || echo "NOT_FOUND"
```

- **EXISTS** → อ่าน `docker-compose.yml` แสดงให้ user เห็น → ถามว่าจะ reconfigure ไหม
  - ถ้า **ไม่** → ข้ามไปขั้นที่ 4
  - ถ้า **ใช่** → ไปขั้นที่ 2
- **NOT_FOUND** → ไปขั้นที่ 2

---

## ขั้นที่ 2 — เก็บข้อมูล Config

ใช้ `AskUserQuestion` tool ถาม **4 ข้อพร้อมกัน**:

1. **Container name** — header: "Container Name", options: `postgres-local` (Recommended), `postgres-dev`, `postgres-app`
2. **Database name** — header: "Database Name", options: `mydb` (Recommended), `appdb`, `devdb`
3. **Port** — header: "Port", options: `5432` (Recommended), `5433`, `5434`
4. **PostgreSQL version** — header: "PG Version", options: `16` (Recommended), `15`, `14`, `latest`

> 💡 Username/Password จะใช้ค่า dev default (`root`/`password`) — แก้ได้ภายหลังใน `.env`

---

## ขั้นที่ 3 — สร้างไฟล์

หลังได้ค่าทั้งหมดแล้ว สร้างไฟล์ตามลำดับด้วย Write tool:

### 3.1 — สร้าง `docker-compose.yml`

```yaml
services:
  postgres:
    image: postgres:<version>
    container_name: <container_name>
    environment:
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_DB: ${POSTGRES_DB}
    ports:
      - "<port>:5432"
    restart: unless-stopped
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

> ✅ `docker-compose.yml` commit ได้ — ไม่มี credentials โดยตรง

### 3.2 — สร้าง `.env.example`

```env
# PostgreSQL credentials (copy ไฟล์นี้เป็น .env แล้วแก้ค่า)
POSTGRES_USER=root
POSTGRES_PASSWORD=your_password_here
POSTGRES_DB=<dbname>
```

> ✅ `.env.example` commit ได้ — เป็น template ให้ทีม

### 3.3 — สร้าง `.env` (ถ้ายังไม่มี)

ตรวจสอบก่อน:
```bash
test -f .env && echo "EXISTS" || echo "NOT_FOUND"
```

- **NOT_FOUND** → สร้าง `.env` ด้วย dev defaults:

```env
# PostgreSQL credentials (local dev)
# ⚠️ LOCAL DEV ONLY — เปลี่ยน password ก่อนใช้งาน production
POSTGRES_USER=root
POSTGRES_PASSWORD=password
POSTGRES_DB=<dbname>
```

- **EXISTS** → **ไม่** เขียนทับ → แจ้ง user ว่า `.env` มีอยู่แล้ว ให้ตรวจสอบว่ามี `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB` ครบ

### 3.4 — Add ใน `.gitignore`

```bash
grep -qxF '.env' .gitignore 2>/dev/null || echo '.env' >> .gitignore
```

> ⚠️ `.env` ต้อง gitignored เสมอ — `.env.example` commit ได้

แจ้ง user ว่าสร้างไฟล์ครบแล้ว

---

## ขั้นที่ 4 — ถาม Docker Compose Up

ใช้ `AskUserQuestion` tool ถาม 1 ข้อ:

- **question:** "ต้องการ start PostgreSQL ด้วย `docker compose up -d` ตอนนี้เลยไหมคะ บอส?"
- **header:** "Start Now?"
- **options:**
  - `เริ่มเลยค่ะ` — description: "รัน docker compose up -d ทันที"
  - `ยังไม่ตอนนี้` — description: "สรุปผลและจบ"

- **เริ่มเลยค่ะ** → ไปขั้นที่ 5
- **ยังไม่ตอนนี้** → แสดงสรุปผล → จบ

---

## ขั้นที่ 5 — Start Docker Compose

ตรวจสอบ Docker daemon ก่อน:

```bash
docker info > /dev/null 2>&1 && echo "DOCKER_OK" || echo "DOCKER_NOT_RUNNING"
```

- **DOCKER_NOT_RUNNING** → แจ้ง user: "กรุณาเปิด Docker Desktop ก่อนนะคะ บอส" → หยุด

รัน:
```bash
docker compose up -d
```

Verify:
```bash
docker compose ps
```

สรุปผลให้ user เห็น:
```
✅ PostgreSQL พร้อมใช้งานแล้วค่ะ บอส!

🐘 Container : <container_name>
🔌 Port      : localhost:<port>
📁 Database  : <dbname>
🔗 Connection: postgresql://root:***@localhost:<port>/<dbname>

📁 ไฟล์ที่สร้าง:
  ✅ docker-compose.yml   — commit ได้
  ✅ .env.example         — commit ได้ (template)
  ✅ .env                 — gitignored (credentials จริง)

💡 คำสั่งที่ใช้บ่อย:
  docker compose up -d    — เริ่ม
  docker compose down     — หยุด
  docker compose logs postgres — ดู logs
```

---

## ข้อควรระวัง

- `.env` ต้อง gitignored เสมอ — ห้าม commit
- ถ้า `.env` มีอยู่แล้ว → **ไม่** เขียนทับ
- ถ้า Docker ไม่รัน → หยุดและแจ้ง user ก่อน ห้าม proceed ต่อ
