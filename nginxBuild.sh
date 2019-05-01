#!/bin/bash

log=$1
$version=$2

#读取配置文件
current_path=$(pwd)
nginx="nginx-"$2
nginxtar=$nginx.tar.gz


#安装nginx
cd /home/soft
if [ ! -f $nginxtar ]
then
    wget http://mirrors.sohu.com/nginx/$nginxtar
fi

if [ -f $nginxtar ];then echo ${nginx}" download success" >> $log;
else echo ${nginx}" download fail" >> $log;exit;fi

tar xzf $nginxtar
cd /home/soft/$nginx
./configure --prefix=/home/soft/nginx --sbin-path=/home/soft/nginx/sbin/nginx  --conf-path=/home/soft/nginx/conf/nginx.conf
make && make install
touch /etc/init.d/nginx
cat $current_path/nginxStart.conf >> /etc/init.d/nginx
chkconfig --add /etc/init.d/nginx
chmod a+x /etc/init.d/nginx

rm -rf /home/soft/$php7tar
mv /home/soft/$php7 /home/soft/install/$php7

echo ${nginx}"success please input 'service nginx start' to start php-fpm" && input 'nginx -v' check version>> $log;