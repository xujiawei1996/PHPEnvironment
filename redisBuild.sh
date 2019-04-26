#!/bin/bash

log=$1
$version=$2

# 读取配置文件
current_path=$(pwd)
redis="redis-"$2
redistar=${redis}.tgz

cd /home/soft

# 下载redis
if [  ! -f $redistar ]
then wget https://pecl.php.net/get/$redistar
fi

if [ -f $redistar ];then echo ${redistar}" download success" >> $log;
else echo ${redistar} "download fail">>$log;exit;fi

#
# 安装Redis扩展
#
cd /home/soft
tar zxvf $redistar
cd $redis
/home/soft/php7/bin/phpize
./configure --with-php-config=/home/soft/php7/bin/php-config
make && make install
if [ $?==0 ];then echo ${redis}" install success" >> $log;
else echo ${redis}" install fail" >> $log;exit;fi

rm -rf /home/soft/$redistar
mv /home/soft/$redis /home/soft/install/$redis