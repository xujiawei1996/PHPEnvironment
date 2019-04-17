#!/bin/bash

log=$1

#读取配置文件
current_path=$(pwd)
msgpackVersion=`cat $current_path/conf.ini | grep msgpack | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
msgpack="msgpack-"${msgpackVersion}

cd /home/soft

#
# 安装msgpack所需要的依赖
#

# 下载msgpack
if [ ! -f $msgpack.tgz ]; then  wget https://pecl.php.net/get/$msgpack.tgz; fi
if [ $?==0 ];then echo ${msgpack}" download success" >> $log;
else echo ${msgpack}" download fail" >> $log;fi

#
# 安装Redis扩展
#
cd /home/soft
tar zxvf $msgpack.tgz && cd $msgpack
/home/soft/php7/bin/phpize
./configure --with-php-config=/home/soft/php7/bin/php-config
make && make install
if [ $?==0 ];then echo ${msgpack}" install success" >> $log;
else echo ${msgpack}" install fail" >> $log;fi
cd $current_path
