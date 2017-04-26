base:
  '*':
    - init.env_init
    - zabbix.install
prod:
  'lb01.glk.com':
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
  'lb02.glk.com':
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
  'web01.blog.glk.com':
    - nginx.web-nginx-inside
	- wordpress.install
  'web02.blog.glk.com':
    - nginx.web-nginx-inside
    - wordpress.install