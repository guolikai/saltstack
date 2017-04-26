include:
  - pkg.pkg-init

pcre-source-install:
  file.managed:
    - name: /App/src/OPS/pcre-8.38.tar.gz
    - source: salt://pcre/files/pcre-8.38.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /App/src/OPS && tar xf pcre-8.38.tar.gz -C /App/build/OPS && cd /App/build/OPS/pcre-8.38 && ./configure --prefix=/usr/local/pcre && make && make install
    - unless: test -d /usr/local/pcre
    - reuqire:
      - file: pcre-source-install
