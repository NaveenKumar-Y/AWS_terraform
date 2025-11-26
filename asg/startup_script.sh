#!/bin/bash


sudo yum update -y
sudo yum install nginx -y


sudo systemctl start nginx
sudo systemctl enable nginx


echo "<h1>Version 1</h1>" | sudo tee /usr/share/nginx/html/index.html

