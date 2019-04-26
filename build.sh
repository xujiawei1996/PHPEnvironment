#!/bin/bash

current_path=$(pwd)
mkdir -p /home/soft
cd /home/soft
touch build.log

log='/home/soft/build.log'

# 读取配置信息
php7Version=`cat $current_path/conf.ini | grep 'php7Version' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
php7orNot=`cat $current_path/conf.ini | grep 'php7orNot' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`

nginxVersion=`cat $current_path/conf.ini | grep 'nginxVersion' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
nginxorNot=`cat $current_path/conf.ini | grep 'nginxorNot' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`

redisVersion=`cat $current_path/conf.ini | grep 'redisVersion' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
redisorNot=`cat $current_path/conf.ini | grep 'redisorNot' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`

swooleVersion=`cat $current_path/conf.ini | grep 'swooleVersion' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
swooleorNot=`cat $current_path/conf.ini | grep 'swooleorNot' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`

libmemcachedVersion=`cat $current_path/conf.ini | grep 'libmemcachedVersion' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
libmemcachedorNot=`cat $current_path/conf.ini | grep 'libmemcachedorNot' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`

msgpackVersion=`cat $current_path/conf.ini | grep 'msgpackVersion' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
msgpackorNot=`cat $current_path/conf.ini | grep 'msgpackorNot' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`

xdebugVersion=`cat $current_path/conf.ini | grep 'xdebugVersion' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`
xdebugorNot=`cat $current_path/conf.ini | grep 'xdebugorNot' | awk -F':' '{ print $2 }' | sed s/[[:space:]]//g`

if [ $php7orNot == 1 ]
then
    cd $current_path
    source $current_path/phpBuild.sh $log $php7Version
fi

if [ $nginxorNot == 1 ]
then
    cd $current_path
    source $current_path/nginxBuild.sh $log $nginxVersion
fi

if [ $redisorNot == 1 ]
then
    cd $current_path
    source $current_path/redisBuild.sh $log $redisVersion
fi

if [ $libmemcachedorNot == 1 ]
then
    cd $current_path
    source $current_path/libmemcachedBuild.sh $log $libmemcachedVersion
fi

if [ $swooleorNot == 1 ]
then
    cd $current_path
    source $current_path/swooleBuild.sh $log $swooleVersion
fi

if [ $msgpackorNot == 1 ]
then
    cd $current_path
    source $current_path/xdebugBuild.sh $log $msgpackVersion
fi

if [ $xdebugorNot == 1 ]
then
    cd $current_path
    source $current_path/msgpackBuild.sh $log $xdebugVersion
fi

cd /home/soft
rm -rf *.tar *.gz *.tgz
