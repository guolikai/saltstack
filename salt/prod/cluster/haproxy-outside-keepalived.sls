include:
  - keepalived.install
 
keepalived-service:
  file.managed:
     - name: /etc/keepalived/keepalived.conf
     - source: salt://cluster/files/haproxy-outside-keepalived.cfg
     - user: root
     - group: root
     - mode: 644
     - template: jinja
     {% if grains['fqdn'] == 'lb01.glk.com' %}
     - ROUTEID: haproxy_ha
     - STATEID: MASTER
     - PRIORITYID: 150
     {% elif grains['fqdn'] == 'lb02.glk.com' %}
     - ROUTEID: haproxy_ha
     - STATEID: BACKUP
     - PRIORITYID: 100
     {% endif %}
  service.running:
    - name: keepalived
    - enable: True
    - watch:
      - file: keepalived-service
