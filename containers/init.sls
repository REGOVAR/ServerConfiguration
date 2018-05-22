containers.pkgs:
  pkg.installed:
    - pkgs:
      - lxc

/etc/lxc/default.conf:
  file.managed:
    - source: salt://containers/default.conf
    - mode: 644

/etc/lxc/lxc-net:
  file.managed:
    - source: salt://containers/lxc-net
    - mode: 644

lxc-net:
  service.running:
    - require:
      - pkg: containers.pkgs
    - watch:
      - file: /etc/lxc/lxc-net
