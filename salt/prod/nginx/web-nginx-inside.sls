include:
  - nginx.install

nginx-directory:
  file.directory:
   - name: /App/opt/OPS/nginx/conf/vhost
   - require:
     - cmd: nginx-source-install

nginx-service:
  file.managed:
    - name: /App/opt/OPS/nginx/conf/nginx.conf
    - source: salt://nginx/files/web-nginx-inside.conf
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: /etc/init.d/nginx restart
    - require:
      - cmd: nginx-init
    - watch:
      - file: nginx-service
#  service.running:
#    - name: nginx
#    - enable: True
#    - reload: True
#    - require:
#      - cmd: nginx-init
#    - watch:
#      - file: nginx-service
