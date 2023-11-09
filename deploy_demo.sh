#!/usr/bin/bash
#
# Deploy a tiny demo web app for MACC testing.

if [ -z "$1" ]
  then echo "Usage: deploy_demo [hostname]"
  exit
fi

echo
echo "Installing the webserver, NGINX."
sudo apt install nginx

echo
echo "Installing certbot for SSL certs with Let's Encrypt."
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

echo
echo "Modifying the web server host name to $1."
sed "s/server_name _/server_name $1/" /etc/nginx/sites-available/default
sudo systemctl reload nginx

echo
echo "Obtaining an SSL cert for $1 from Let's Encrypt."
sudo certbot --nginx -d $1

echo
echo "Deploying the demo HTML file."
sudo cp index.html /var/www/html/
