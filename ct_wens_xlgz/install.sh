#!/bin/bash

# 安装基础数据
apt update -y && apt install -y curl

# 更新软件包
echo '更新apt 安装基础依赖'
apt update -y && apt install -y unzip wget git vim build-essential cmake libssl-dev libsdl1.2-compat-dev libavcodec-dev libavutil-dev openssh-client dmidecode ffmpeg inetutils-ping

# openssl 安装
echo "openssl 安装"
cd /
wget https://www.openssl.org/source/openssl-1.1.1k.tar.gz
tar -xvzf openssl-1.1.1k.tar.gz && rm -rf openssl-1.1.1k.tar.gz && cd openssl-1.1.1k
./config shared --openssldir=/usr/local/openssl --prefix=/usr/local/openssl
make && make install
echo "/usr/local/lib64/" >> /etc/ld.so.conf
echo "/usr/local/openssl/lib" >> /etc/ld.so.conf
ldconfig
ln -s /usr/local/openssl/bin/openssl  /usr/local/bin/openssl 
openssl version -a

# libsrtp 安装
echo "libsrtp 安装"
cd /
curl -o libsrtp-2.3.0.tar.gz https://gitee.com/dearheng/libsrtp/raw/master/libsrtp-2.3.0.tar.gz
tar -xvzf libsrtp-2.3.0.tar.gz && rm -rf libsrtp-2.3.0.tar.gz && cd /libsrtp-2.3.0
./configure --enable-openssl
make -j8 && make install

# 安装nvm
echo '安装nvm'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
source ~/.bashrc
nvm -v

# 安装nodejs  安装3个版本
echo '安装nodejs'
nvm install 12.22.12
nvm use 12.22.12

node -v && npm -v

# 安装init.js的依赖
echo '安装init.js的依赖'
cd /init && npm i --production --registry=https://registry.npmmirror.com