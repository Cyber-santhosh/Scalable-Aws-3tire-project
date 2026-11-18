#!/bin/bash
set -e

echo "=== Starting Web Tier Setup ==="

# 1. Install Nginx if not already installed
if ! command -v nginx &> /dev/null; then
    echo "Installing Nginx..."
    yum install -y nginx
fi

# 2. Deploy index.html to default web root
mkdir -p /usr/share/nginx/html
cp -f /home/ec2-user/application-code/web-tier/index.html /usr/share/nginx/html/index.html
chmod 644 /usr/share/nginx/html/index.html

# 3. Clean default configs and install application nginx.conf
rm -f /etc/nginx/conf.d/default.conf
rm -f /etc/nginx/default.d/*.conf 2>/dev/null || true
cp -f /home/ec2-user/application-code/nginx.conf /etc/nginx/nginx.conf

# 4. Test and restart Nginx
nginx -t
systemctl restart nginx
systemctl enable nginx

echo "=== Web Tier Nginx running successfully on port 80 ==="

