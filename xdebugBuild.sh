#!/bin/bash

log=$1

#读取配置文件
current_path=$(pwd)
xdebugVersion=`cat $current_path/conf.ini | grep xdebug | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
xdebug="msgpack-"${xdebugVersion}

if [ ! -f $xdebug.tgz ]; then  wget http://pecl.php.net/get/$xdebug.tgz; fi

#
# 安装Xdebug扩展
#
cd /home/soft
tar zxvf $xdebug.tgz && cd $xdebug
/home/soft/php7/bin/phpize
./configure --with-php-config=/home/soft/php7/bin/php-config
make && make install
cd ..