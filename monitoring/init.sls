monitoring.pkgs:
  pkg.installed:
    - pkgs:
      - dstat
      - lm-sensors
      - lsof
      - htop
      - smartmontools
      - strace
      - time

smartmontools:
  service.running:
    - require:
      - pkg: monitoring.pkgs
    - watch:
      - file: /etc/default/smartmontools
      - file: /etc/smartd.conf

smartctl -s on /dev/sda:
  cmd.run:
    - onlyif: "smartctl -i /dev/sda | grep -q 'SMART support is: Disabled'"
    - require:
      - pkg: monitoring.pkgs

smartctl -s on /dev/sdb:
  cmd.run:
    - onlyif: "smartctl -i /dev/sdb | grep -q 'SMART support is: Disabled'"
    - require:
      - pkg: monitoring.pkgs

/etc/default/smartmontools:
  file.managed:
    - source: salt://monitoring/smartmontools-default
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: monitoring.pkgs

/etc/smartd.conf:
  file.managed:
    - source: salt://monitoring/smartd.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: monitoring.pkgs
