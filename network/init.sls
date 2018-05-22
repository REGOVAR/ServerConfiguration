network.pkgs:
  pkg.installed:
    - pkgs:
      - ca-certificates
      - curl
      - openssh-client
      - openssh-server

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://network/sshd_config
    - template: jinja
    - mode: 644
