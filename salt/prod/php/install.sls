include:
  - user.nobody
  
pkg-php:
  pkg.installed:
    - names:
      - epel-release
#      - mysql-devel
      - openssl-devel
      - curl
      - libcurl-devel
      - freetype
      - freetype-devel
      - gd
      - gd-devel
      - openssl 
      - swig
      - libcurl
      - libcurl-devel
      - libmcrypt 
      - libmcrypt-devel 
      - libjpeg-turbo
      - libjpeg-turbo-devel
      - libpng
      - libpng-devel
      - libxml2
      - libxml2-devel
      - libxslt-devel
      - mhash
      - zlib
      - zlib-devel

libiconv-source-install:
  file.managed:
    - name: /App/src/OPS/libiconv-1.15.tar.gz
    - source: salt://php/files/libiconv-1.15.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /App/src/OPS && tar zxf libiconv-1.15.tar.gz -C /App/build/OPS && cd /App/build/OPS/libiconv-1.15 && ./configure --prefix=/App/install/OPS/libiconv && make && make install
    - require: 
      - file: libiconv-source-install
    - unless: test -d /App/install/OPS/libiconv

php-source-install:
  file.managed:
    - name: /App/src/OPS/php-5.6.30.tar.gz
    - source: salt://php/files/php-5.6.30.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /App/src/OPS && tar zxf php-5.6.30.tar.gz -C /App/build/OPS && cd /App/build/OPS/php-5.6.30 &&  ./configure --prefix=/App/install/OPS/php-5.6.30 --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv-dir=/App/install/OPS/libiconv/ --with-freetype-dir  --with-jpeg-dir  --with-png-dir  --with-zlib --with-libxml-dir=/usr --enable-xml  --disable-rpath  --enable-bcmath   --enable-shmop   --enable-sysvsem  --enable-inline-optimization --with-curl  --enable-mbregex  --enable-fpm --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets  --with-xmlrpc --enable-zip --enable-soap --enable-short-tags --enable-static --with-xsl --with-fpm-user=$AppUser --with-fpm-group=$AppGroup --enable-ftp --without-pear --disable-phar --enable-opcache=no && make && make install && ln -s /App/install/OPS/php-5.6.30 /App/opt/OPS/php && ln  -s /App/install/OPS/php-5.6.30/etc /App/conf/OPS/php && ln -s /App/install/OPS/php-5.6.30/logs /App/log/OPS/php 
    - require:
      - file: php-source-install
      - user: nobody-user-group
    - unless: test -d /App/install/OPS/php-5.6.30

php-ini:
  file.managed:
    - name: /App/install/OPS/php-5.6.30/etc/php.ini
    - source: salt://php/files/php.ini-production
    - user: root
    - group: root
    - mode: 644

php-fpm:
  file.managed:
    - name: /App/install/OPS/php-5.6.30/etc/php-fpm.conf
    - source: salt://php/files/php-fpm.conf.default
    - user: root
    - group: root
    - mode: 644

php-init:
  file.managed:
    - name: /etc/init.d/php
    - source: salt://php/files/php-5.6.30.init
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: php-source-install
  cmd.run:
    - name: echo "/etc/init.d/php start" >> /etc/rc.local  && chmod +x /etc/rc.local
    - unless:  test $(grep '/etc/init.d/php' /etc/rc.local|wc -l) -eq 1
    - require:
      - file: php-init

php-service:
  cmd.run:
    - name:  /etc/init.d/php restart
    - require:
      - file: php-init
    - watch:
      - file: php-ini
      - file: php-fpm

