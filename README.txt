��Ⱥ�ܹ�����˵��top.sls
base:
  '*':
    - init.env_init
    - zabbix.install
prod:
  'lb01.glk.com':				#��Ⱥ���ؾ�������
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
  'lb02.glk.com':				#��Ⱥ���ؾ�������
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
  'web01.blog.glk.com':				#��ȺWEB�������
    - nginx.web-nginx-inside
  'web02.blog.glk.com':				#��ȺWEB�������
    - nginx.web-nginx-inside


�ļ���ע��
1.salt�ļ��������
salt "*" state.sls cluster.haproxy-outside test=True saltenv=prod
2.salt�ļ�ִ�У�
salt "*" state.highstate
3.��Ⱥ���ؾ�����������ʱ���ǵ��޸�salt/prod/cluster/haproxy-outside-keepalived.sls�����Ӧ��������
[root@admin ~]# cat /srv/salt/prod/cluster/haproxy-outside-keepalived.sls  | grep glk.com
     {% if grains['fqdn'] == 'lb01.glk.com' %}
     {% elif grains['fqdn'] == 'lb02.glk.com' %}
