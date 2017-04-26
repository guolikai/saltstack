yum_repo_release:
  pkg.installed:
    - sources:
      - epel-release: http://mirrors.aliyun.com/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
    - unless: rpm -qa | grep epel-release-7-9
