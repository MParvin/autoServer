#!/usr/bin/bash
#This script will run on CentOS 7x

# disable selinux for current boot
setenforce 0
# disable selinux permanently
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

yum install -q -y epel-release
yum -q -y install lynx vim-enhanced wget unzip git nginx mysql-server

systemctl enable firewalld
systemctl start firewalld
firewall-cmd --zone=public --add-service http
firewall-cmd --zone=public --add-service http --permanent

PHP_VERSION="70"
yum install -q -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install -q -y \
  php${PHP_VERSION}-php \
  php${PHP_VERSION}-php-fpm \
  php${PHP_VERSION}-php-mysqlnd \
  php${PHP_VERSION}-php-intl \
  php${PHP_VERSION}-php-opcache \
  php${PHP_VERSION}-php-gd \
  php${PHP_VERSION}-php-mbstring \
  php${PHP_VERSION}-php-pecl-memcache \
  php${PHP_VERSION}-php-imap \
  php${PHP_VERSION}-php-bcmath \
  php${PHP_VERSION}-php-xml \
  php${PHP_VERSION}-php-process \
  php${PHP_VERSION}-php-pecl-xdebug \
  php${PHP_VERSION}-php-pecl-zip \
  php${PHP_VERSION}-php-dbg
ln -s /usr/bin/php${PHP_VERSION} /usr/bin/php
ln -s /usr/bin/php${PHP_VERSION}-phpdbg /usr/bin/phpdbg

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/
