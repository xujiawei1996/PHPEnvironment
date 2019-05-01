#!/bin/bash

log=$1

#读取配置文件
current_path=$(pwd)
msgpack="msgpack-"$2
msgpacktar=${msgpacktar}.tgz

cd /home/soft

#
# 安装msgpack所需要的依赖
#

# 下载msgpack
if [ ! -f $msgpacktar ]; then  wget https://pecl.php.net/get/$msgpack.tgz; fi

if [ -f $msgpacktar ];then echo ${msgpacktar}" download success" >> $log;
else echo ${msgpacktar}" download fail" >> $log;exit;fi

#
# 安装Redis扩展
#
cd /home/soft
tar zxvf ${msgpacktar} && cd ${msgpack}
/home/soft/php7/bin/phpize
./configure --with-php-config=/home/soft/php7/bin/php-config
make && make install

if [ $?==0 ];then echo ${msgpack}" install success" >> $log;
else echo ${msgpack}" install fail" >> $log;exit;fi

rm -rf /home/soft/$msgpacktar
mv /home/soft/$msgpack /home/soft/install/$msgpack