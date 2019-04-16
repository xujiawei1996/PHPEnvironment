#!/bin/bash

log=$1

#读取配置文件
current_path=$(pwd)
php7Version=`cat $current_path/conf.ini | grep php7 | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
php7="php-"${php7Version}

#
# 安装php所需要的依赖
#
yum install -y libxml2 
yum install -y libxml2-devel
yum install -y curl curl-devel
yum install -y libpng libpng-devel
yum install -y freetype-devel
yum install -y libxslt-devel

cd /home/soft

#
# 下载php7
#
if [ ! -f $php7.tar.gz ];then wget http://mirrors.sohu.com/php/$php7.tar.gz; fi

if [ $?==0 ];then echo ${php7}" download success" >> $log;
else echo ${php7}" download fail" >> $log;fi

#
# 编译PHP引擎
#
cd /home/soft
tar zxvf ${php7}.tar.gz && cd ${php7}
./configure --prefix=/home/soft/php7 --with-curl \
    --with-freetype-dir \
    --with-gd \
    --with-gettext \
    --with-iconv-dir \
    --with-kerberos \
    --with-libdir=lib64 \
    --with-libxml-dir \
    --with-mysql \
    --with-mysqli \
    --with-openssl \
    --with-pcre-regex \
    --with-pdo-mysql \
    --with-pdo-sqlite \
    --with-pear \
    --with-png-dir \
    --with-xmlrpc \
    --with-xsl \
    --with-zlib \
    --enable-fpm \
    --enable-bcmath \
    --enable-libxml \
    --enable-inline-optimization \
    --enable-gd-native-ttf \
    --enable-mbregex \
    --enable-mbstring \
    --enable-opcache \
    --enable-pcntl \
    --enable-shmop \
    --enable-soap \
    --enable-sockets \
    --enable-sysvsem \
    --enable-xml \
    --enable-zip
make && make install && make clean
if [ $?==0 ];then echo ${php7}" install success" >> $log;
else echo ${php7}" install fail" >> $log;fi

#复制配置文件
cp -R  /home/soft/${php7}/sapi/fpm/php-fpm.conf /home/soft/php7/etc/php-fpm.conf
cp -R /home/soft/${php7}/php.ini-development /home/soft/php7/lib/php.ini
cp -R /home/soft/php7/etc/php-fpm.d/www.conf.default /home/soft/php7/etc/php-fpm.d/www.conf
#复制php-fpm到开机启动项中
cp -R /home/soft/php7/sbin/php-fpm /etc/init.d/php-fpm
#复制php到环境变量
cp -R /home/soft/php7/bin/php /usr/bin/php7

#启动php-fpm
/etc/init.d/php-fpm

if [ $?==0 ];then echo "php7 start success" >> $log;
else echo "php7 start fail,Please perform the '/etc/init.d/php-fpm' check" >> $log;fi
