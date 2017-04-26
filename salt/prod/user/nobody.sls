nobody-user-group:
  group.present:
    - name: nobody
    - gid: 1001

  user.present:
    - name: nobody
    - fullname: nobody
    - shell: /sbin/nologin
    - uid: 1001
    - gid: 1001
