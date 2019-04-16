#!/bin/bash

#if [ $USER != "root" ]; then  sudo su; fi
#mkdir -p /home/soft
#cd /home/soft
#touch build.log

log='/home/soft/build.log'

#安装PHP7
#source ./phpBuild.sh $log

source ./nginxBuild.sh $log
