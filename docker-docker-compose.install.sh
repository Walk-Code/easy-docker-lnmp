#!/bin/sh
PATH=/usr/local/php/bin:/opt/someApp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# 安装docker
apt install docker.io | sh

# 安装docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

echo 'verify docker: '
docker_pid="ps -ef |  grep docker | grep -v grep"
echo docker run pid $docker_pid  

echo 'verify docker compose:'
docker_compose_version="docker-compose --version"
echo $docker_compose_version