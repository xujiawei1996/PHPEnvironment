#!/bin/bash

#读取配置文件
current_path=$(pwd)
php7Version=`cat $current_path/conf.ini | grep 'php7Version' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
php7orNot=`cat $current_path/conf.ini | grep 'php7orNot' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
php7="php-"${php7Version}


if [ $php7orNot == 1 ]
then
    echo 1111;
else
    echo 2222;
fi
