#!/bin/bash

# --- Nginx Installation and Configuration (as before) ---
echo "Installing Nginx..."
sudo dnf update -y
sudo dnf install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<html><body><h1>Hello from EC2 Nginx Server!</h1><p>User data logs are redirected.</p></body></html>" | sudo tee /usr/share/nginx/html/index.html
echo "Nginx installed and configured."

# --- CloudWatch Agent Installation and Configuration ---
echo "Installing CloudWatch Agent..."
sudo dnf install -y amazon-cloudwatch-agent

# Create the CloudWatch Agent configuration file
# Write the JSON config using tee
echo '${local.cloudwatch_agent_config}' | sudo tee /opt/aws/amazon-cloudwatch-agent/bin/config.json > /dev/null

# Start the CloudWatch Agent with the new config
echo "Starting CloudWatch Agent..."
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s

echo "CloudWatch Agent setup complete."
echo "User data script finished."