zabbix-agent:
  Zabbix_Server: 10.10.10.10
  Zabbix_IP: {{ grains['fqdn_ip4'][0] }}

dns-server-inside: 10.10.10.10
dns-server-outside: 223.5.5.5
