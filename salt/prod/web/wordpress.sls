include:
  - php.install
  - nginx.web-nginx-inside
  - web.install

web-bbs:
  file.managed:
    - name: /App/opt/OPS/nginx/conf/vhost/wordpress.conf
    - source: salt://web/files/wordpress.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: php-service
    - watch_in:
      - service: nginx-service
	  
web-bbs-conf:
  file.managed:
    - name: /App/opt/OPS/nginx/html/wordpress/wp-config.php
    - source: salt://web/files/wp-config.php
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: php-service