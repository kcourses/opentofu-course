#!/bin/bash

sudo apt update
sudo apt install -y nginx

echo "<h1>${message}</h1>" > /var/www/html/index.html

sudo systemctl restart nginx
sudo systemctl enable nginx