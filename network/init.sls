network.pkgs:
  pkg.installed:
    - pkgs:
      - ca-certificates
      - curl
      - openssh-client
      - openssh-server

/etc/network/interfaces:
  file.managed:
    - source: salt://network/interfaces
    - mode: 644

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://network/sshd_config
    - mode: 644
