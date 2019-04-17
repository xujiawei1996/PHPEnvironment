#!/bin/bash

log=$1

#读取配置文件
current_path=$(pwd)
libmemcachedVersion=`cat $current_path/conf.ini | grep libmemcached | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
libmemcached="libmemcached-"${libmemcachedVersion}

cd /home/soft

wget https://launchpad.net/libmemcached/1.0/$libmemcachedVersion/+download/$libmemcached.tar.gz
if [ $?==0 ];then echo ${libmemcached}" download success" >> $log;
else echo ${libmemcached}" download fail" >> $log;fi
tar -zxvf $libmemcached.tar.gz
cd $libmemcached
/home/soft/php7/bin/phpize
./configure --prefix=/home/soft/libmemcached --with-memcached
make && make install
if [ $?==0 ];then echo ${libmemcached}" install success" >> $log;
else echo ${libmemcached}" install fail" >> $log;fi
cd ..



wget https://github.com/php-memcached-dev/php-memcached/archive/php7.zip
if [ $?==0 ];then echo "memcached-2.2.0 download success" >> $log;
else echo "memcached-2.2.0 download fail" >> $log;fi
unzip php7.zip
cd php-memcached-php7/ 
/home/soft/php7/bin/phpize
./configure --with-php-config=/home/soft/php7/bin/php-config --disable-memcached-sasl
make && make install
if [ $?==0 ];then echo "memcached-2.2.0 install success" >> $log;
else echo "memcached-2.2.0 install fail" >> $log;fi
cd ..

