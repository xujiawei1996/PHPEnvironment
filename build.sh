#!/bin/bash

current_path=$(pwd)
mkdir -p /home/soft
cd /home/soft
touch build.log

log='/home/soft/build.log'

#安装基础扩展
yum install -y dos2unix
yum -y install gcc+ gcc-c++


#安装nginx所需要的依赖
yum -y install pcre-devel openssl openssl-devel

#
# 安装php所需要的依赖
#
yum install -y libxml2
yum install -y libxml2-devel
yum install -y openssl openssl-dev openssl-devel
yum install -y curl curl-devel
yum install -y libpng libpng-devel
yum install -y freetype-devel
yum install -y libxslt-devel

#
# 安装redis所需要的依赖
#
yum install -y autoconf

#
# 安装swoole所需要的依赖
#
yum install -y autoconf
yum install -y m4


cd $current_path
chmod a+x *.sh
dos2unix $current_path/*.sh


#安装PHP7
source $current_path/phpBuild.sh $log
source $current_path/nginxBuild.sh $log
source $current_path/redisBuild.sh $log
source $current_path/libmemcachedBuild.sh $log
source $current_path/swooleBuild.sh $log
source $current_path/xdebugBuild.sh $log
source $current_path/msgpackBuild.sh $log

cd /home/soft
rm -rf *.tar *.gz *.tgz
