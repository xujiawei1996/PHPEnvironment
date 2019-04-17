#!/bin/bash

current_path=$(pwd)
#if [ $USER != "root" ]; then  sudo su; fi
mkdir -p /home/soft
cd /home/soft
touch build.log

log='/home/soft/build.log'

yum install -y dos2unix
yum -y install gcc+ gcc-c++

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
