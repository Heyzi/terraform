#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y 
sudo su -c "/bin/echo Hello from $HOSTNAME > /usr/share/nginx/html/index.html"
sudo systemctl enable --now nginx
  