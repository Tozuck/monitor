# Navigate to the directory where the virtual environment and monitor.py are located
cd ~/monitor

source myenv/bin/activate

nohup python monitor.py > /var/log/monitor.log 2>&1 &
