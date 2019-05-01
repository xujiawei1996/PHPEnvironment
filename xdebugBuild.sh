#!/bin/bash

log=$1

#读取配置文件
current_path=$(pwd)
xdebug="msgpack-"$2
xdebugtar=${xdebug}.tgz

if [ ! -f ${xdebugtar} ]; then  wget http://pecl.php.net/get/${xdebugtar}; fi
if [ -f ${xdebugtar} ];then echo ${xdebugtar}" download success" >> $log
else echo ${xdebugtar}" download fail" >> $log;exit;
fi

#
# 安装Xdebug扩展
#
cd /home/soft
tar zxvf ${xdebugtar} && cd $xdebug
/home/soft/php7/bin/phpize
./configure --with-php-config=/home/soft/php7/bin/php-config
make && make install

if [ $?==0 ];then echo ${xdebug}" install success" >> $log;
else echo ${xdebug}" install fail" >> $log;exit;fi

rm -rf /home/soft/$xdebugtar
mv /home/soft/$xdebug /home/soft/install/$xdebug