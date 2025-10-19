#!/bin/bash
# setup_fileserver.sh - Automate Samba share setup on Kali/Linux

LOGFILE=~/linux-infra-automation/scripts/fileserver_setup.log
exec > >(tee -a "$LOGFILE") 2>&1

SHARE_DIR="/srv/shared"
SAMBA_USER="fileshareuser"
SAMBA_PASS="SAMBAPASS123"

echo "=== Updating System ==="
sudo apt-get update -qq -y

echo "=== Installing Samba ==="
sudo apt-get install -y -qq samba

echo "=== Creating shared directory ==="
sudo mkdir -p $SHARE_DIR
sudo chmod 2770 $SHARE_DIR
sudo chown nobody:"sambashare" $SHARE_DIR

echo "=== Creating Samba user ==="
sudo useradd -M -s /sbin/nologin $SAMBA_USER || true
echo -e "$SAMBA_PASS\n$SAMBA_PASS" | sudo smbpasswd -s -a $SAMBA_USER
sudo usermod -aG sambashare $SAMBA_USER

echo "=== Configuring Samba share ==="
sudo bash -c "cat > /etc/samba/smb.conf <<'EOF'
[global]
   workgroup = WORKGROUP
   server string = Automated Samba Server
   map to guest = Bad User
   log file = /var/log/samba/%m.log
   max log size = 50
   server role = standalone server

[shared]
   path = /srv/shared
   browseable = yes
   writable = yes
   valid users = $SAMBA_USER
   create mask = 0660
   directory mask = 0770
EOF"

echo "=== Restarting Samba ==="
sudo systemctl restart smbd
sudo systemctl enable smbd

echo "=== Testing Samba Configuration ==="
sudo testparm -s

echo "=== File Server Setup Complete ==="
echo "Share: //$(hostname -I | awk '{print $1}')/shared"
echo "User: $SAMBA_USER | Password: $SAMBA_PASS"
echo "Log saved to: $LOGFILE"
                               
