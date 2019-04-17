#!/bin/bash

log=$1

#读取配置文件
current_path=$(pwd)
swooleVersion=`cat $current_path/conf.ini | grep swoole | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
swoole="swoole-src-"${swooleVersion}

cd /home/soft

#安装hredis
git clone https://github.com/redis/hiredis.git
if [ $?==0 ];then
cd hiredis && git checkout v0.14.0
make && make install
echo "hiredis install success" >> $log
else echo "hiredis install fail" >> $log;exit
fi


cd /home/soft
#安装nghttp2
wget https://github.com/nghttp2/nghttp2/releases/download/v1.34.0/nghttp2-1.34.0.tar.gz
if [ $?==0 ];then
tar zxvf nghttp2-1.34.0.tar.gz
cd nghttp2-1.34.0
./configure
make && make install
cd ..
fi


cd /home/soft
#
# 下载swoole
#
if [ ! -f $swoole.tar.gz ];then git clone https://github.com/swoole/swoole-src.git; fi
if [ $?==0 ];then echo ${swoole}" download success" >> $log;
else echo ${swoole}" download fail" >> $log;exit
fi

#
# 编译swoole
#
cd /home/soft
cd swoole-src && git checkout v$swooleVersion
/home/soft/php7/bin/phpize
./configure --with-php-config=/home/soft/php7/bin/php-config  --enable-sockets --enable-openssl --enable-http2 --enable-mysqlnd
make && make install  
if [ $?==0 ];then echo ${swoole}" install success" >> $log;
else echo ${swoole}" install fail" >> $log;exit
fi
make clean
cd $current_path