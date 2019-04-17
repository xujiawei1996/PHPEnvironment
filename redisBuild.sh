#!/bin/bash

log=$1

#读取配置文件
current_path=$(pwd)

cd /home/soft

# 下载redis
git clone https://github.com/phpredis/phpredis.git
if [ $?==0 ];then echo ${redis}" download success" >> $log;
else echo ${redis}" download fail" >> $log;exit;fi

#
# 安装Redis扩展
#
cd /home/soft
cd phpredis/
git checkout php7-ipv6
/home/soft/php7/bin/phpize
./configure --with-php-config=/home/soft/php7/bin/php-config
make && make install
if [ $?==0 ];then echo ${redis}" install success" >> $log;
else echo ${redis}" install fail" >> $log;exit;fi
cd $current_path