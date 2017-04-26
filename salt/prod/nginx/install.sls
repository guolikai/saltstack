include:
  - pkg.pkg-init
  - pcre.install
  - user.nobody

nginx-source-install:
  file.managed:
    - name: /App/src/OPS/nginx-1.10.0.tar.gz
    - source: salt://nginx/files/nginx-1.10.0.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /App/src/OPS && tar zxf nginx-1.10.0.tar.gz -C /App/build/OPS && cd /App/build/OPS/nginx-1.10.0 && ./configure    --prefix=/App/install/OPS/nginx-1.10.0    --with-http_stub_status_module    --without-http_auth_basic_module    --without-http_autoindex_module    --without-http_browser_module    --without-http_geo_module    --without-http_limit_req_module    --without-http_limit_conn_module    --without-http_map_module    --without-http_memcached_module  --without-http_scgi_module    --without-http_split_clients_module    --without-http_userid_module    --without-http_uwsgi_module    --without-mail_imap_module    --without-mail_pop3_module    --without-mail_smtp_module    --without-poll_module    --without-select_module    --with-stream && make && make install && ln -s /App/install/OPS/nginx-1.10.0 /App/opt/OPS/nginx && ln  -s /App/install/OPS/nginx-1.10.0/conf /App/conf/OPS/nginx && ln -s /App/install/OPS/nginx-1.10.0/logs /App/log/OPS/nginx 
    - unless: test -d /App/install/OPS/nginx-1.10.0
    - require:
      - user: nobody-user-group
      - pkg: pkg-init
      - file: nginx-source-install
      - cmd: pcre-source-install

nginx-init:
  file.managed:
    - name: /etc/init.d/nginx
    - source: salt://nginx/files/nginx.init
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: nginx-source-install
  cmd.run:
    - name: echo "/etc/init.d/nginx start" >> /etc/rc.local && chmod +x /etc/rc.local
    - unless: test $(grep '/etc/init.d/nginx' /etc/rc.local|wc -l) -eq 1
    - require:
      - file: nginx-init
