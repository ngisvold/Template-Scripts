#!/bin/bash

# Update package list
sudo apt update

# Install fail2ban if it's not already installed
sudo apt install -y fail2ban

# Create or modify jail.local for SSH protection
cat <<EOL | sudo tee /etc/fail2ban/jail.local
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 10
findtime = 3600
bantime = 1800
EOL

# Restart fail2ban to apply changes
sudo systemctl restart fail2ban

# Check fail2ban status for SSH jail
sudo fail2ban-client status sshd
