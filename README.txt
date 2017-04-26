集群架构解析说明top.sls
base:
  '*':
    - init.env_init
    - zabbix.install
prod:
  'lb01.glk.com':				#集群负载均衡外网
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
  'lb02.glk.com':				#集群负载均衡外网
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
  'web01.blog.glk.com':				#集群WEB后端内网
    - nginx.web-nginx-inside
  'web02.blog.glk.com':				#集群WEB后端内网
    - nginx.web-nginx-inside


文件备注：
1.salt文件测试命令：
salt "*" state.sls cluster.haproxy-outside test=True saltenv=prod
2.salt文件执行：
salt "*" state.highstate
3.集群负载均衡外网配置时，记得修改salt/prod/cluster/haproxy-outside-keepalived.sls里面对应的域名；
[root@admin ~]# cat /srv/salt/prod/cluster/haproxy-outside-keepalived.sls  | grep glk.com
     {% if grains['fqdn'] == 'lb01.glk.com' %}
     {% elif grains['fqdn'] == 'lb02.glk.com' %}
