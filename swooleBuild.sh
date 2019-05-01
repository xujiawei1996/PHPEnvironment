#!/bin/bash

log=$1

#读取配置文件
current_path=$(pwd)
swoole="swoole-"$2
swooletar=${swoole}.tgz

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
if [ ! -f $swooletar ];then wget https://pecl.php.net/get/${swooletar}; fi

if [ -f $swooletar ]
then echo ${swooletar}" download success" >> $log;
else echo ${swooletar}" download fail" >> $log;exit;
fi

#
# 编译swoole
#
cd /home/soft
tar -zxvf ${swooletar}
cd $swoole
/home/soft/php7/bin/phpize
./configure --with-php-config=/home/soft/php7/bin/php-config  --enable-sockets --enable-openssl --enable-http2 --enable-mysqlnd
make && make install  
if [ $?==0 ];then echo ${swoole}" install success" >> $log;
else echo ${swoole}" install fail" >> $log;exit
fi

rm -rf /home/soft/$swooletar
mv /home/soft/$swoole /home/soft/install/$swoole