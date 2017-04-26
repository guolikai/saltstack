zabbix-agent-rpm:
  file.managed:
    - name: /App/src/OPS/zabbix-agent-3.2.4-2.el7.x86_64.rpm
    - source: salt://zabbix/files/zabbix-agent-3.2.4-2.el7.x86_64.rpm
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /App/src/OPS && rpm -ivh zabbix-agent-3.2.4-2.el7.x86_64.rpm
    - unless: test -d /etc/zabbix
    - require:
      - file: zabbix-agent-rpm

/etc/zabbix/zabbix_agentd.conf:
  file.managed:
    - source: salt://zabbix/files/zabbix_agentd.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      ZABBIX_SERVER: {{ pillar['zabbix-agent']['Zabbix_Server'] }}
      ZABBIX_AGENT: {{ pillar['zabbix-agent']['Zabbix_IP'] }}
    - require:
      - cmd: zabbix-agent-rpm
  service.running:
    - name: zabbix-agent
    - enable: True
    - watch:
      - file: /etc/zabbix/zabbix_agentd.conf
