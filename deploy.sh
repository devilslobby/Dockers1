#!/bin/bash
set -e

echo "Starting deployment..."

# Variables
APP_DIR="/home/ubuntu/my-app"
SERVICE_NAME="my-app"

# Create application directory
mkdir -p $APP_DIR

# Stop existing service if running
sudo systemctl stop $SERVICE_NAME || true

# Install Python dependencies
cd $APP_DIR
pip3 install -r requirements.txt

# Set permissions
chmod +x app.py

# Create systemd service file
sudo tee /etc/systemd/system/$SERVICE_NAME.service > /dev/null <<EOF
[Unit]
Description=My Flask App
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=$APP_DIR
ExecStart=/usr/bin/python3 $APP_DIR/app.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start service
sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME
sudo systemctl start $SERVICE_NAME

echo "Deployment completed successfully!"
echo "Service status:"
sudo systemctl status $SERVICE_NAME