#!/bin/bash
# hardening.sh - Basic Linux hardening automation script
# Description: Automates basic Linux security best practices

LOGFILE=~/linux-infra-automation/scripts/hardening.log
exec > >(tee -a "$LOGFILE") 2>&1

echo "=== System Hardening Script Started ==="

# 1. Update system packages
echo "=== Updating and upgrading system ==="
sudo apt-get update -qq -y 

# 2. Configure basic firewall using ufw
echo "=== Configuring UFW Firewall ==="
sudo apt-get install -y -qq ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw --force enable

# 3. Disable root SSH login
echo "=== Disabling root SSH login ==="
sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# 4. Disable password SSH auth (key-based only)
echo "=== Enforcing SSH key authentication ==="
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart ssh || sudo systemctl restart sshd

# 5. Enable unattended upgrades
echo "=== Setting up unattended security updates ==="
sudo apt-get install -y -qq unattended-upgrades apt-listchanges
sudo dpkg-reconfigure -f noninteractive unattended-upgrades

# 6. Secure permissions
echo "=== Securing permissions ==="
sudo chmod -R go-rwx /etc/ssh
sudo chmod -R go-rwx /var/log

# 7. Show firewall & SSH summary
echo "=== Firewall Status ==="
sudo ufw status verbose

echo "=== SSH Config Summary ==="
sudo grep -E "PermitRootLogin|PasswordAuthentication" /etc/ssh/sshd_config

echo "=== Hardening Complete ==="
echo "Log saved to: $LOGFILE"
