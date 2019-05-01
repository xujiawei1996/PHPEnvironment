#!/bin/bash

log=$1
$version=$2

#读取配置文件
current_path=$(pwd)
memcached="memcached-"$2
memcachedtar=${memcached}.tgz

cd /home/soft

#下载
if [ -f ${libmemcachedtar} ];then
wget https://pecl.php.net/get/${memcachedtar}
fi

if [ -f ${memcachedtar} ]
then echo ${memcachedtar}" download success" >> $log;
else echo ${memcachedtar}" download fail" >> $log;exit;
fi


tar -zxvf  ${memcachedtar}
cd $memcached
/home/soft/php7/bin/phpize
./configure --prefix=/home/soft/memcached --with-memcached
make && make install
if [ $?==0 ];then echo ${memcached}" install success" >> $log;
else echo ${memcached}" install fail" >> $log;exit;
fi


rm -rf /home/soft/$memcachedtar
mv /home/soft/$memcached /home/soft/install/$memcached


