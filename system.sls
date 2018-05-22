system.pkgs:
  pkg.installed:
    - pkgs:
      - ncdu
      - ntp
      - sudo
      - tree

ntp:
  service.running:
    - enable: True
    - require:
      - pkg: system.pkgs

/etc/hostname:
  file.managed:
    - source: salt://hostname
    - template: jinja
    - user: root
    - mode: 644

/etc/hosts:
  file.managed:
    - source: salt://hosts
    - template: jinja
    - user: root
    - mode: 644
