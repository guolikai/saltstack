/etc/resolv.conf:
  file.managed:
    - source: salt://init/files/resolv.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      DNS_SERVER: {{ pillar['dns-server-inside'] }}
