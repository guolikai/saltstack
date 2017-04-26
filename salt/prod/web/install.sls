include:
 - user.nobody

wordpress-install:
  file.managed:
    - name: /App/src/OPS/wordpress-4.7.3-zh_CN.tar.gz
    - source: salt://web/files/wordpress-4.7.3-zh_CN.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /App/src/OPS && tar zxf wordpress-4.7.3-zh_CN.tar.gz -C /App/install/OPS && ln -s /App/install/OPS/wordpress /App/opt/OPS/nginx/html/wordpress
    - unless: test -d /App/install/OPS/wordpress
    - require:
      - file: wordpress-install
      - user: nobody-user-group
