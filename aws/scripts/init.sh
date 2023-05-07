#!/bin/bash

apt-get update -y
apt-get upgrade -y
apt-get install -y apt-mirror nginx

cat  <<\EOF > /etc/apt/mirror.list
#
# Erlang
#

deb http://ppa.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu jammy main
deb http://ppa.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu focal main
deb http://ppa.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu bionic main

deb http://ppa.novemberain.com/rabbitmq/rabbitmq-erlang/deb/debian bullseye main
deb http://ppa.novemberain.com/rabbitmq/rabbitmq-erlang/deb/debian buster main

#
# RabbitMQ server
#

deb http://ppa.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu jammy main
deb http://ppa.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu focal main
deb http://ppa.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu bionic main

deb http://ppa.novemberain.com/rabbitmq/rabbitmq-erlang/deb/debian bullseye main
deb http://ppa.novemberain.com/rabbitmq/rabbitmq-erlang/deb/debian buster main

clean http://archive.ubuntu.com/ubuntu
EOF

apt-mirror
