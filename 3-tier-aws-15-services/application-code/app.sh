#!/bin/bash
set -e

echo "=== Starting App Tier Setup ==="

# 1. Install Node.js & npm if not present
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
    echo "Node.js/npm not found. Installing Node.js LTS via NodeSource..."
    curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
    yum install -y nodejs
fi

# 2. Install PM2 globally if not present
if ! command -v pm2 &> /dev/null; then
    echo "Installing PM2 globally..."
    npm install -g pm2
fi

# 3. Ensure permissions
mkdir -p /home/ec2-user/app-tier
chown -R ec2-user:ec2-user /home/ec2-user/app-tier
chmod -R 755 /home/ec2-user/app-tier

# 4. Install dependencies and start with PM2 under ec2-user
su - ec2-user << 'EOF'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

cd /home/ec2-user/app-tier

# Install packages
npm install --omit=dev

# Start app with PM2
pm2 delete app-tier || true
pm2 start index.js --name "app-tier"
pm2 save
EOF

# 5. Enable PM2 on system reboot
env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ec2-user --hp /home/ec2-user 2>/dev/null || true

echo "=== App Tier running successfully on port 4000 ==="
