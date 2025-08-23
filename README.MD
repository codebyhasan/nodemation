# Nodemation - One-Click n8n Setup on Ubuntu Server

**Fully automated script to install, configure, and secure n8n on any Ubuntu server with NGINX and SSL**

[![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com/)
[![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://nginx.org/)
[![Let's Encrypt](https://img.shields.io/badge/Let's%20Encrypt-003A70?style=for-the-badge&logo=letsencrypt&logoColor=white)](https://letsencrypt.org/)

---

## Features

- One-click installation for n8n with Docker Compose
- Automatic NGINX reverse proxy setup
- SSL certificate issuance via Certbot
- n8n updated to latest version automatically
- Secure configuration out of the box

---

## Quick Run

### One-Line Installation

```bash
sudo wget https://raw.githubusercontent.com/CodeByHasan/nodemation/main/nodemation.sh -O nodemation.sh && chmod +x nodemation.sh && ./nodemation.sh
````

> **Important:** Make sure your domain points to your server's public IP before running the script.

---

## Domain Setup

Before running the script, ensure your domain points to your server's public IP address.

### Cloudflare Setup

1. Login to **Cloudflare** → **Dashboard** → Select your domain
2. Go to **DNS** → **Records**
3. Add an **A Record**:

```
Type: A
Name: your-subdomain (e.g., n8n, automation, workflow, or @ for root domain)
IPv4 address: Your Server Public IP (e.g., 3.25.254.106)
Proxy status: DNS only (gray cloud) or Proxied (orange cloud)
TTL: Auto
```

### Namecheap Setup

1. Login to **Namecheap** → **Domain List** → **Manage your domain**
2. Go to **Advanced DNS**
3. Add an **A Record**:

```
Type: A Record
Host: your-subdomain (e.g., n8n, automation, workflow, or @ for root domain)
Value: Your Server Public IP (e.g., 3.25.254.106)
TTL: Automatic or 5 minutes
```

### GoDaddy Setup

1. Login to **GoDaddy** → **My Products** → **Manage DNS**
2. Add a **Record**:

```
Type: A
Name: your-subdomain (e.g., n8n, automation, workflow, or @)
Value: Server Public IP (e.g., 3.25.254.106)
TTL: 1 Hour or default
```

> Note: DNS propagation may take 5 minutes to 1 hour.

---

## After Setup

Access n8n at `https://your-subdomain.yourdomain.com` (replace with your chosen subdomain and domain)

---

## What Gets Installed

| Component               | Purpose                      |
| ----------------------- | ---------------------------- |
| Docker & Docker Compose | Container orchestration      |
| NGINX                   | Reverse proxy server         |
| Certbot                 | SSL certificate management   |
| n8n                     | Workflow automation platform |

---

**Developed by HASAN**
🌐 [codebyhasan.link](https://codebyhasan.link)

📅 Date: 2025-08-22

---

If this helped you, give it a star!
