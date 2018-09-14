monitoring_pkgs:
  pkg.installed:
    - pkgs:
      - dstat
      - lm-sensors
      - lsof
      - htop
      - pv
      - smartmontools
      - strace
      - time

smartmontools:
  service.running:
    - enable: True
    - require:
      - pkg: monitoring_pkgs
    - watch:
      - file: /etc/default/smartmontools
      - file: /etc/smartd.conf

{% for device in ['sda','sdb'] %}
smartctl -s on /dev/{{ device }}:
  cmd.run:
    - onlyif: "smartctl -i /dev/{{ device }} | grep -q 'SMART support is: Disabled'"
    - require:
      - pkg: monitoring_pkgs
{% endfor %}

/etc/default/smartmontools:
  file.managed:
    - source: salt://monitoring/smartmontools-default
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: monitoring_pkgs

/etc/smartd.conf:
  file.managed:
    - source: salt://monitoring/smartd.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: monitoring_pkgs
