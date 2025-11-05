#!/bin/bash
###
 # @Author: yangheng
 # @Date: 2025-11-04 16:00:02
 # @LastEditTime: 2025-11-05 12:05:28
 # @FilePath: /docker_bash_image/cbi_priv/install.sh
 # @Description: 
 #
###
apt update -y
apt install -y unzip git

# 安装TUI编辑器
curl https://getmic.ro | bash

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

echo "libsrtp 安装"
cd /
curl -o libsrtp-2.3.0.tar.gz https://gitee.com/dearheng/libsrtp/raw/master/libsrtp-2.3.0.tar.gz
tar -xvzf libsrtp-2.3.0.tar.gz && rm -rf libsrtp-2.3.0.tar.gz && cd /libsrtp-2.3.0
./configure --enable-openssl
make -j8 && make install

echo "zlm 安装"
mkdir -p /zlm
# 下载预编译好的可执行文件 区分x86_64和aarch64
if [ "$ARCH" = "x86_64" ] || [ "$ARCH" = "i686" ]; then
    DOWNLOAD_ZLM_URL="https://res.cvvii.com/zlm/x86_64.zip"
else
    DOWNLOAD_ZLM_URL="https://res.cvvii.com/zlm/aarch64.zip"
fi
curl -L -o /zlm/lib.zip $DOWNLOAD_ZLM_URL
unzip /zlm/lib.zip -d /zlm/lib

echo "下载NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

# 安装nvm
echo "安装nvm"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# source ~/.bashrc
nvm -v

# 安装nodejs
echo "安装nodejs"
nvm install 16.20.2
nvm use 16.20.2
node -v && npm -v
