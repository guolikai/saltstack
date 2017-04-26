include:
  - pkg.pkg-init

keepalived-install:
  file.managed:
    - name: /App/src/OPS/keepalived-1.2.19.tar.gz
    - source: salt://keepalived/files/keepalived-1.2.19.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /App/src/OPS && tar zxf keepalived-1.2.19.tar.gz -C /App/build/OPS && cd /App/build/OPS/keepalived-1.2.19 && ./configure --prefix=/App/install/OPS/keepalived-1.2.19 --disable-fwmark && make && make install && ln -s /App/install/OPS/keepalived-1.2.19 /App/opt/OPS/keepalived
    - unless: test -d /App/install/OPS/keepalived-1.2.19
    - require:
      - pkg: pkg-init
      - file: keepalived-install

keepalived-init:
  file.managed:
    - name: /etc/init.d/keepalived
    - source: salt://keepalived/files/keepalived.init
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: keepalived-install
  cmd.run:
    - name: systemctl enable keepalived
    - unless:  systemctl list-units --type=service | grep keepalived
    - require:
      - file: keepalived-init

/etc/sysconfig/keepalived:
  file.managed:
    - source: salt://keepalived/files/keepalived.sysconfig
    - user: root
    - group: root
    - mode: 644

keepalived-config-dir:
  file.directory:
  - name: /etc/keepalived
  - user: root
  - group: root
  - mode: 755
