# php7+swoole+nginx 部署脚本
一个快速php7+swoole+nginx部署脚本

要求：
1.Linux version > 2.3.32

2.gcc version > 4.8
你可以通过```cat /proc/version```查看版本

配置文件在conf.ini中，默认配置如下
  -  php7:7.1.8
  -  nginx:1.8.1
  - redis:3.1.3
  - swoole:4.2.2
  - libmemcached:1.0.16
  - msgpack:2.0.2
  - xdebug:2.5.5
其中php7的memcached扩展默认为2.2.0

所有软件的存放目录为：/home/soft
日志文件为build.log
关于php7，会在ect/init.d/生成php-fpm启动脚本，你可以通过```service php-fpm start```启动,```service php-fpm stop```停止

关于nginx，会在ect/init.d/生成nginx启动脚本，你可以通过```service nginx start```启动,```service nginx stop```停止

目前没有php5，后续会跟进。也希望大家可以提交自己的脚本代码。

# PHP+swoole+nginx deployment scripts
A quick php7+swoole+nginx deployment script

Requirements:

1. The Linux version > 2.3.32

2. The GCC version > 4.8

You can use the ` ` ` cat/proc/version ` ` ` view version



The configuration file is in conf.ini. The default configuration is as follows

  -  php7:7.1.8
  -  nginx:1.8.1
  - redis:3.1.3
  - swoole:4.2.2
  - libmemcached:1.0.16
  - msgpack:2.0.2
  - xdebug:2.5.5

The php7 memcached extension defaults to 2.2.0


The directory for all software is: /home/soft

The log file is build.log

In about php7, ect/init. D/generate PHP - FPM startup scripts, you can use the ` ` ` service PHP - FPM start ` ` ` start, ` ` ` service PHP - FPM stop ` ` ` stop

In about nginx, ect/init. D/generate nginx startup scripts, you can use the ` ` ` service nginx start ` ` ` start, ` ` ` service nginx stop ` ` ` stop

There is no php5 at present, and we will follow up later. Also hope that you can submit their own script code.

