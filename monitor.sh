#!/bin/bash

# Update package lists
apt-get update

# Disable the firewall (use with caution)
ufw disable

# Install Apache2
sudo apt install -y apache2

# Modify Apache configuration to listen on port 4567 only
sudo sed -i 's/Listen 80/Listen 4567/' /etc/apache2/ports.conf

# Update the default virtual host configuration to use port 4567
sudo sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:4567>/' /etc/apache2/sites-available/000-default.conf

# Restart Apache to apply changes
sudo systemctl restart apache2

# Create and set permissions for a file in the web directory
sudo touch /var/www/html/file.txt
sudo chown www-data:www-data /var/www/html/file.txt
sudo chmod 664 /var/www/html/file.txt

# Wait and navigate to the monitor directory
sleep 2
cd ~/monitor
sleep 2

# Install Python3 virtual environment and create a virtual environment
sudo apt install -y python3-venv
python3 -m venv myenv

# Activate the virtual environment and install requirements
source myenv/bin/activate
pip install -r req.txt

# Make the monitor script executable
chmod +x ~/monitor/start_monitor.sh

# Add a cron job to run the monitor script at reboot
(crontab -l 2>/dev/null; echo "@reboot bash ~/monitor/start_monitor.sh") | crontab -

# Run the monitor script in the background and log output
nohup python monitor.py > monitor.log 2>&1 &

# Deactivate the virtual environment
deactivate
