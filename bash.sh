current_path=$(pwd)

#安装基础扩展
yum install -y dos2unix
dos2unix $current_path/*.sh
dos2unix $current_path/*.conf

cd $current_path
chmod a+x *.sh

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
