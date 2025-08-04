# 🏗️ Inception – Docker Infrastructure (42 Project)

**Inception** is a system administration and DevOps project from the 42 curriculum.  
The goal is to build a fully functional **multi-container Docker environment** using only Docker Compose, with services configured from scratch.

---

## 🧱 Project Structure

inception/
├── Makefile
├── srcs/
│ ├── docker-compose.yml
│ └── requirements/
│ ├── mariadb/
│ │ ├── conf/
│ │ │ ├── init.sh
│ │ │ └── server_conf.cnf
│ │ └── Dockerfile
│ ├── nginx/
│ │ ├── conf/
│ │ │ └── nginx.conf
│ │ └── Dockerfile
│ └── wordpress/
│ ├── conf/
│ │ ├── auto_config.sh
│ │ └── www.conf
│ └── Dockerfile


---

## 🚀 Overview

This infrastructure includes the following Dockerized services:

| Service   | Description                                   |
|-----------|-----------------------------------------------|
| **Nginx**     | Web server configured with SSL (TLS)          |
| **WordPress** | PHP site with dynamic content (blog, CMS)     |
| **MariaDB**   | Relational database engine for WordPress      |

All services are built from custom **Dockerfiles** and connected via **Docker networks and volumes** to ensure data persistence and isolation.

---

## 📦 Technologies Used

- 🐳 Docker & Docker Compose
- 🐬 MariaDB (as MySQL alternative)
- 🕸️ Nginx with SSL (using OpenSSL)
- 📝 WordPress with auto configuration (PHP-FPM)
- 🐧 Debian base images
- 🔐 Secure file permissions and ownership

---

## ⚙️ Usage

### 🔧 1. Configuration

Create environment variables inside the `.env` file or directly in `docker-compose.yml` if needed (DB name, user, passwords, domain, etc.).

### ▶️ 2. Build and Run

```bash
make        # Equivalent to docker-compose up --build -d
```
### 🛑 3. Stop and Clean

make clean   # Equivalent to docker-compose down -v

## 🔐 Security Highlights

    🔒 SSL enabled on Nginx using self-signed certificate

    🛠️ WordPress auto-configuration script for security and convenience

    🐚 Secure init.sh for MariaDB to set root password, database, and user

    📁 File permissions properly managed in mounted volumes

## 🌐 Accessing the Services

Once containers are running, go to:

https://localhost/

You can customize the hostname by editing your /etc/hosts file or configuring DNS (e.g., 127.0.0.1 yourdomain.com)

🧪 Testing

    ✅ WordPress should be accessible and operational with your configured user

    ✅ MariaDB database should persist across container restarts

    ✅ HTTPS should be active via Nginx
