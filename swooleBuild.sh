#!/bin/bash

log=$1

#读取配置文件
current_path=$(pwd)
swooleVersion=`cat $current_path/conf.ini | grep swoole | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
swoole="swoole-src-"${swooleVersion}

#
# 安装swoole所需要的依赖
#
yum install -y autoconf

cd /home/soft

#安装hredis
wget https://github.com/redis/hiredis/archive/v0.14.0.tar.gz
tar -zxvf v0.14.0.tar.gz
cd hiredis-0.14.0 && make && make install
if [ $?==0 ];then echo ${swoole}" download success" >> $log;
else echo ${swoole}" download fail" >> $log;fi
cd .. && rm -rf v0.14.0.tar.gz


#
# 下载swoole
#
if [ ! -f $swoole.tar.gz ];then wget https://github.com/swoole/swoole-src/archive/v$swooleVersion.tar.gz; fi
if [ $?==0 ];then echo ${swoole}" download success" >> $log;
else echo ${swoole}" download fail" >> $log;fi

#安装nghttp2
wget https://github.com/nghttp2/nghttp2/releases/download/v1.34.0/nghttp2-1.34.0.tar.gz
tar zxvf nghttp2-1.34.0.tar.gz
cd nghttp2-1.34.0
./configure
make && make install
cd .. && rm nghttp2-1.34.0.tar.gz -rf

#
# 编译swoole
#
cd /home/soft
tar zxvf v$swooleVersion.tar.gz && cd $swoole 
/home/soft/php7/bin/phpize
./configure --with-php-config=/home/soft/php7/bin/php-config  --enable-sockets --enable-openssl --enable-http2 --enable-mysqlnd
make && make install  
if [ $?==0 ];then echo ${swoole}" install success" >> $log;
else echo ${swoole}" install fail" >> $log;fi
make clean
cd .. && r m -rf v$swooleVersion.tar.gz