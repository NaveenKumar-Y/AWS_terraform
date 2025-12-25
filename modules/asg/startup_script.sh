#!/bin/bash


sudo yum update -y
sudo yum install httpd -y


sudo systemctl start httpd
sudo systemctl enable httpd

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Fetch ID and AZ using the token
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-id)
# AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
# PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4)

cat <<EOF > /var/www/html/index.html
<body style="background-color: green;">
    <h1>Version ${VERSION_NUMBER}, Jai AA - $INSTANCE_ID </h1>
</body>
EOF
# echo "<h1>Version 1, Jai NTR </h1>" | sudo tee /var/www/html/index.html 
echo "<h1>This is fallback page, main page is not working</h1>" | sudo tee /usr/share/httpd/noindex/index.htm

# mkdir -p /var/www/html/health
# echo "OK" > /var/www/html/health/index.html


