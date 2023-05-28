FROM debian:bullseye

ARG TARGET_HOSTNAME

RUN apt update -y
RUN apt upgrade -y

RUN apt install -y apt-mirror

COPY files/etc/apt/mirror.list /etc/apt/mirror.list

RUN apt install -y nginx
RUN rm /etc/nginx/sites-enabled/default

COPY files/nginx/configure_nginx.sh /tmp/configure_nginx.sh
RUN chmod +x /tmp/configure_nginx.sh
RUN /tmp/configure_nginx.sh ${TARGET_HOSTNAME}

RUN rm /tmp/configure_nginx.sh
