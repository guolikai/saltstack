include:
  - haproxy.install

haproxy-service:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://etcd/etcd-cluster/files/haproxy-outside.cfg
    - user: root
    - group: root
    - mode: 644
    - template: jinja
  service.running:
    - name: haproxy
    - enable: True
    - reload: True
    - require:
      - cmd: haproxy-init
    - watch:
      - file: haproxy-service
