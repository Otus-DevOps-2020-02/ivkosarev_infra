#!/bin/bash
set -e

# Run Puma
cd /etc/systemd/system/
touch unit.service
echo "[Unit]"> unit.service
echo "Description=Routing Settings Service" >> unit.service
echo "After=network.target" >> unit.service

echo "[Service]" >> unit.service
echo "Type=oneshot" >> unit.service
echo "ExecStart=puma -d" >> unit.service

echo "[Install]" >> unit.service
echo "WantedBy=multi-user.target" >> unit.service
sudo systemctl enable unit






