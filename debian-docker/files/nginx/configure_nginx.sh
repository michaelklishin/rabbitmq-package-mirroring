#!/bin/sh

target_hostname=${1}

tee /etc/nginx/sites-enabled/rabbitmq.apt.mirror.conf <<EOF
server {
  listen 80;
  listen 443 ssl;
  server_name ${target_hostname};
  ssl_certificate /etc/ssl/certs/${target_hostname}.pem;
  ssl_certificate_key /etc/ssl/private/${target_hostname}.key;


  location / {
    alias /var/spool/apt-mirror/mirror/ppa1.novemberain.com/;
    try_files $uri $uri/ =404;
  }

  location /mirrors {
    alias /var/spool/apt-mirror/mirror/ppa1.novemberain.com/;
    try_files $uri $uri/ =404;
  }
}
EOF
