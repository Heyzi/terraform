#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y 
sudo echo "$HOSTANME" > /var/www/html/index.html
sudo systemctl enable --now nginx

