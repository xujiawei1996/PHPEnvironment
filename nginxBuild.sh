#!/bin/bash

log=$1

#安装nginx所需要的依赖
yum -y install pcre-devel openssl openssl-devel

#读取配置文件
current_path=$(pwd)
nginxVersion=`cat $current_path/conf.ini | grep nginx | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
nginx="nginx-"${nginxVersion}

cd /home/soft

#安装nginx
if [ $USER != "root" ];then sudo su;fi

cd /home/soft && wget http://mirrors.sohu.com/nginx/$nginx.tar.gz
if [ $?==0 ];then echo ${nginx}" download success" >> $log;
else echo ${nginx}" download fail" >> $log;fi

tar xzf $nginx.tar.gz
cd /home/soft/$nginx 
./configure --prefix=/home/soft/nginx --sbin-path=/home/soft/nginx/sbin/nginx  --conf-path=/home/soft/nginx/conf/nginx.conf   
make && make install
touch /etc/init.d/nginx
cat $current_path/nginxStart.conf >> /etc/init.d/nginx
chkconfig --add /etc/init.d/nginx
chmod a+x /etc/init.d/nginx
cd $current_path
