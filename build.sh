#!/bin/bash

#if [ $USER != "root" ]; then  sudo su; fi
#mkdir -p /home/soft
#cd /home/soft
#touch build.log

log='/home/soft/build.log'

#安装PHP7
source ./phpBuild.sh $log
source ./nginxBuild.sh $log
source ./redisBuild.sh $log
source ./libmemcachedBuild.sh $log
source ./swooleBuild.sh $log
source ./xdebugBuild.sh $log
source ./msgpackBuild.sh $log
