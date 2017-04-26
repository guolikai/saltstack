setuptools-source-install:
  file.managed:
    - name: /App/src/OPS/setuptools-7.0.tar.gz
    - source: salt://etcd/files/setuptools-7.0.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /App/src/OPS && tar zxf setuptools-7.0.tar.gz -C /App/install/OPS && cd /App/install/OPS/setuptools-7.0 && python setup.py install
    - unless: test -d /App/install/OPS/setuptools-7.0
    - require:
      - file: setuptools-source-install	
	  
pip-source-install:
  file.managed:
    - name: /App/src/OPS/pip-9.0.1.tar.gz
    - source: salt://etcd/files/pip-9.0.1.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /App/src/OPS && tar zxf pip-9.0.1.tar.gz -C /App/install/OPS && cd /App/install/OPS/pip-9.0.1 && python setup.py install
    - unless: test -d /App/install/OPS/pip-9.0.1
    - require:
      - cmd: setuptools-source-install	  
      - file: pip-source-install	
	  
etcd-source-install:
  file.managed:
    - name: /App/src/OPS/etcd-v3.1.5-linux-amd64.tar.gz
    - source: salt://etcd/files/etcd-v3.1.5-linux-amd64.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /App/src/OPS && tar zxf etcd-v3.1.5-linux-amd64.tar.gz -C /App/install/OPS && ln -s /App/install/OPS/etcd-v3.1.5-linux-amd64 /App/opt/OPS/etcd
    - unless: test -d /App/install/OPS/etcd-v3.1.5-linux-amd64
    - require:
      - file: etcd-source-install 
	 
etcd-init:
  file.managed:
    - name: /App/src/OPS/start.sh
    - source: salt://etcd/files/start.sh
    - user: root
    - group: root
    - mode: 755	  
  cmd.run:
    - name: echo "/App/opt/OPS/start.sh start" >> /etc/profile && source /etc/profile
    - unless: test $(grep '/App/opt/OPS/start.sh' /etc/profile |wc -l) -eq 1
    - require:
	  - cmd: etcd-source-install
	  
etcd-service:
  cmd.run:
    - name: /App/src/OPS/start.sh start
	- require:
	  - cmd: pip-source-install
	  - cmd: etcd-source-install
	  