#!/bin/bash

apt-get update

ufw disable

sudo apt install -y apache2

sudo touch /var/www/html/file.txt
sudo chown www-data:www-data /var/www/html/file.txt
sudo chmod 664 /var/www/html/file.txt
sleep 2
cd ~/monitor
sleep 2

sudo apt install -y python3-venv
python3 -m venv myenv


source myenv/bin/activate
pip install -r req.txt
chmod +x ~/monitor/start_monitor.sh

(crontab -l 2>/dev/null; echo "@reboot bash ~/monitor/start_monitor.sh") | crontab -

nohup python monitor.py > monitor.log 2>&1 &

deactivate
