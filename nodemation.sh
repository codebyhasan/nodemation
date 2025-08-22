#!/bin/bash

# =============================================
# Nodemaion n8n Auto Setup Script
# Demo Domain: demo.example.com
# Demo Email: demo@example.com
# =============================================

DOMAIN="demo.example.com"
EMAIL="demo@example.com"
N8N_USER="admin"
N8N_PASS="demoPassword123"

echo "=== Updating system packages ==="
sudo apt update -y && sudo apt upgrade -y

echo "=== Installing Docker & Docker Compose ==="
sudo apt install -y docker.io curl
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
newgrp docker

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version

echo "=== Creating n8n directory & docker-compose.yml ==="
mkdir -p ~/n8n && cd ~/n8n

cat > docker-compose.yml <<EOL
version: '3'
services:
  n8n:
    image: n8nio/n8n
    restart: always
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=$N8N_USER
      - N8N_BASIC_AUTH_PASSWORD=$N8N_PASS
      - WEBHOOK_URL=https://$DOMAIN/
    volumes:
      - n8n_data:/home/node/.n8n
volumes:
  n8n_data:
EOL

echo "=== Starting n8n via Docker Compose ==="
docker-compose up -d

echo "=== Installing NGINX & Certbot ==="
sudo apt install -y nginx certbot python3-certbot-nginx
sudo systemctl start nginx
sudo systemctl enable nginx

echo "=== Creating NGINX config ==="
sudo bash -c "cat > /etc/nginx/conf.d/n8n.conf <<EOF
server {
    listen 80;
    server_name $DOMAIN;
    location / {
        proxy_pass http://localhost:5678/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF"

echo "=== Testing & restarting NGINX ==="
sudo nginx -t
sudo systemctl restart nginx

echo "=== Issuing SSL with Certbot ==="
sudo certbot --nginx -d $DOMAIN --non-interactive --agree-tos --email $EMAIL

echo "=== Setup Complete ==="
echo "Access your n8n instance at https://$DOMAIN
