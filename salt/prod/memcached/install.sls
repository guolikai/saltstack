include:
  - libevent.install

memcached-source-install:
  file.managed:
    - name: /App/src/OPS/memcached-1.4.24.tar.gz
    - source: salt://memcached/files/memcached-1.4.24.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /App/src/OPS && tar zxf memcached-1.4.24.tar.gz  -C /App/build/OPS && cd /App/build/OPS/ memcached-1.4.24 && ./configure --prefix=/App/install/OPS/memcached-1.4.24 --enable-64bit --with-libevent=/usr/local/libevent && make && make install && ln -s /App/install/OPS/memcached-1.4.24 /App/opt/OPS/memcached
    - unless: test -d /App/install/OPS/memcached-1.4.24
    - require:
      - cmd: libevent-source-install
      - file: memcached-source-install
