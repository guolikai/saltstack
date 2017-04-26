/usr/sbin/ntpdate time.nist.gov >>/dev/null 2>&1:
  cron.present:
    - user: root
    - minute: 10