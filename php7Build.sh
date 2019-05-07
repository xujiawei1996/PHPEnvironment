#!/bin/bash

log=$1
version=$2

#读取配置文件
current_path=$(pwd)
php7="php-"$2
php7tar=${php7}.tar.gz

cd /home/soft
#
# 下载php7
#
if [ ! -f $php7tar ];then git clone https://github.com/php/php-src.git;
fi

if [ -f $php7tar ];then echo ${php7}" download success" >> $log;
else echo ${php7}" download fail" >> $log;exit;fi

#
# 编译PHP引擎
#
tar zxvf $php7tar && cd php-src && git checkout ${php7}
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
else echo ${php7}" install fail" >> $log;exit;fi

#复制配置文件
cp -R  /home/soft/${php7}/sapi/fpm/php-fpm.conf /home/soft/php7/etc/php-fpm.conf
cp -R /home/soft/${php7}/php.ini-development /home/soft/php7/lib/php.ini
cp -R /home/soft/php7/etc/php-fpm.d/www.conf.default /home/soft/php7/etc/php-fpm.d/www.conf
#复制php-fpm到开机启动项中
touch /etc/init.d/php-fpm
cat $current_path/phpfpmStart.conf >> /etc/init.d/php-fpm
chkconfig --add /etc/init.d/php-fpm
#复制php到环境变量
cp -R /home/soft/php7/bin/php /usr/bin/php7

rm -rf /home/soft/$php7tar
mv /home/soft/$php7 /home/soft/install/$php7

echo ${php7}"success please input 'service php-fpm start' to start php-fpm" && input 'php7 -v' check version>> $log;

