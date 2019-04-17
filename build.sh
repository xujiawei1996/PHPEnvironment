#!/bin/bash

current_path=$(pwd)
#if [ $USER != "root" ]; then  sudo su; fi
mkdir -p /home/soft
cd /home/soft
touch build.log

log='/home/soft/build.log'

cd $current_path
chmod a+x *.sh

#安装PHP7
source ./phpBuild.sh $log
source ./nginxBuild.sh $log
source ./redisBuild.sh $log
source ./libmemcachedBuild.sh $log
source ./swooleBuild.sh $log
source ./xdebugBuild.sh $log
source ./msgpackBuild.sh $log

cd /home/soft
rm -rf *.tar *.gz *.tgz
