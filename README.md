<h1 align="center">🧰 Linux Infrastructure Automation</h1>

<p align="center">
Automating complete Linux server setup — from web and database configuration to file sharing and system hardening — all powered by <b>Bash scripting</b>.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Linux-Automation-0078D4?style=for-the-badge&logo=linux&logoColor=white"/>
  <img src="https://img.shields.io/badge/Bash%20Scripting-000000?style=for-the-badge&logo=gnu-bash&logoColor=white"/>
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white"/>
  <img src="https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white"/>
  <img src="https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white"/>
  <img src="https://img.shields.io/badge/Samba-FFD43B?style=for-the-badge&logo=ubuntu&logoColor=black"/>
  <img src="https://img.shields.io/badge/Security-Hardening-E34F26?style=for-the-badge&logo=shield&logoColor=white"/>
</p>

---

## 🧠 About the Project

A complete automation project using **Bash scripting** to configure and secure essential Linux server components — including a **web server**, **database (MariaDB in Docker)**, **file server (Samba)**, and **system hardening**.

This project automates everything from setup to security in a modular, reusable structure.  
It’s ideal for showcasing your **Linux Administration**, **DevOps**, and **Automation** skills.

---

## ⚙️ Tech Stack & Tools

| Component | Technology Used | Purpose |
|------------|-----------------|----------|
| OS | Kali Linux / Debian-based | Base environment |
| Web Server | Nginx | Host web content |
| Database | MariaDB (Docker) | Isolated DB container |
| File Server | Samba | Network file sharing |
| Security | UFW, SSH, Unattended Upgrades | Firewall & Hardening |
| Scripting | Bash | Full automation |
| Containerization | Docker | Portable and clean setup |

---

## 📁 Project Structure

linux-infra-automation/
├── scripts/
│ ├── setup_webserver.sh
│ ├── setup_mariadb_docker.sh
│ ├── test_mariadb_docker.sh
│ ├── setup_fileserver.sh
│ ├── hardening.sh
│ ├── system_update.sh
|
└── screenshots/

---

🧩 Quick Steps to Run the Project

•First, clone the repository
git clone https://github.com/Eman-gul457/Linux-Infrastructure-Automation.git

•Go inside the project folder
cd linux-infra-automation/scripts

•(Optional) Update the system

•Setup the Web Server
./setup_webserver.sh

•Setup MariaDB in Docker
./setup_mariadb_docker.sh

•Test the MariaDB connection
./test_mariadb_docker.sh

•Setup the File Server (Samba)
./setup_fileserver.sh

•Apply System Hardening
./hardening.sh

---

Note:
🧠 Why We Use Docker for MariaDB
Using Docker ensures the database runs in an isolated and consistent environment, independent of the host system.
It eliminates local configuration and permission issues, simplifies cleanup, and makes the setup easily portable and reproducible across any Linux system.
