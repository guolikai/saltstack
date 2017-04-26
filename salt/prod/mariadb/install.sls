mariadb-install:
  pkg.installed:
    - names:
      - mariadb-server
      - mariadb
      - mariadb-libs
	  
mariadb-service:
  file.managed:
    - name: /etc/my.cnf
      - source: salt://mariadb/files/my-mariadb-rpm.cnf
      - user: root
      - group: root
      - mode: 644
  service.running:
    - name: mariadb
	- enable: True
    - watch:
      - file: mariadb-service
	  - pkg: mariadb-install