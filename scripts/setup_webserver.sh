#!/bin/bash
# setup_webserver.sh - Automate Nginx setup on Kali Linux

LOGFILE=~/linux-infra-automation/scripts/webserver_setup.log
exec > >(tee -a "$LOGFILE") 2>&1

echo "=== Updating System ==="
sudo apt-get update -qq -y

echo "=== Installing Nginx ==="
sudo apt-get install -y -qq nginx

echo "=== Starting & Enabling Nginx ==="
sudo systemctl enable nginx
sudo systemctl start nginx

echo "=== Creating Custom Web Page ==="
sudo rm -f /var/www/html/index.nginx-debian.html
echo "<h1>Welcome to My Automated Linux Project</h1>" | sudo tee /var/www/html/index.html

echo "=== Checking Nginx Status ==="
sudo systemctl status nginx | grep Active

echo "=== Done! Visit http://localhost to see your page ==="
echo "Log saved to: $LOGFILE"
