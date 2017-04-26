include:
  - pkg.pkg-init

haproxy-install:
  file.managed:
    - name: /App/src/OPS/haproxy-1.5.18.tar.gz
    - source: salt://haproxy/files/haproxy-1.5.18.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /App/src/OPS && tar zxf haproxy-1.5.18.tar.gz -C /App/build/OPS && cd /App/build/OPS/haproxy-1.5.18 && make TARGET=linux31 PREFIX=/App/install/OPS/haproxy-1.5.18 && make install PREFIX=/App/install/OPS/haproxy-1.5.18 && ln -s /App/install/OPS/haproxy-1.5.18 /App/opt/OPS/haproxy 
    - unless: test -d /App/install/OPS/haproxy-1.5.18
    - require:
      - pkg: pkg-init
      - file: haproxy-install

haproxy-init:
  file.managed:
    - name: /etc/init.d/haproxy
    - source: salt://haproxy/files/haproxy.init
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: haproxy-install
  cmd.run:
    - name: systemctl enable haproxy
    - unless:  systemctl list-units --type=service | grep haproxy
    - require:
      - file: haproxy-init

net.ipv4.ip_nonlocal_bind:
  sysctl.present:
    - value: 1

haproxy-config-dir:
  file.directory:
  - name: /etc/haproxy
  - user: root
  - group: root
  - mode: 755
