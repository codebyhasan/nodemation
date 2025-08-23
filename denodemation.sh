#!/bin/bash
# full_uninstall_nodemation.sh
# Complete uninstall script for n8n + Docker + Nginx + SSL on Ubuntu

echo "🚨 Starting FULL Uninstallation of Nodemation stack..."

# Stop and remove n8n containers
echo "⏹️ Stopping and removing n8n Docker containers..."
cd ~/n8n 2>/dev/null
if [ -f docker-compose.yml ]; then
  docker-compose down -v --remove-orphans
  echo "✅ n8n containers removed."
fi

# Remove n8n directory
echo "🗑️ Removing ~/n8n project directory..."
rm -rf ~/n8n

# Remove Nginx config and logs
echo "🗑️ Removing Nginx configs..."
rm -f /etc/nginx/conf.d/n8n.conf
rm -f /etc/nginx/sites-enabled/n8n
rm -f /etc/nginx/sites-available/n8n
rm -rf /var/log/nginx/*

# Remove SSL certificates (Let's Encrypt)
echo "🗑️ Removing SSL certificates..."
certbot delete --cert-name demo.example.com || true
rm -rf /etc/letsencrypt/live/*
rm -rf /etc/letsencrypt/archive/*
rm -rf /etc/letsencrypt/renewal/*

# Remove Docker images, volumes, networks
echo "🗑️ Removing Docker images, volumes, and networks..."
docker system prune -af --volumes

# Uninstall Docker & Docker Compose
echo "🗑️ Uninstalling Docker and Docker Compose..."
apt-get remove --purge -y docker docker-engine docker.io containerd runc
rm -f /usr/local/bin/docker-compose
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/docker
rm -rf /var/lib/containerd

# Uninstall Nginx & Certbot
echo "🗑️ Uninstalling Nginx and Certbot..."
apt-get remove --purge -y nginx nginx-common nginx-core certbot python3-certbot-nginx
apt-get autoremove -y
apt-get autoclean -y
rm -rf /etc/nginx

echo "✅ FULL Uninstallation completed successfully!"
echo "👉 Your system is clean. Only Ubuntu base system remains."
