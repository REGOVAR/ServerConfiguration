include:
  - term

arkanosis:
  user.present:
    - home: /home/arkanosis
    - shell: /usr/bin/zsh
    - uid: 1301
    - gid: 1301
    - groups:
      - sudo
    - remove_groups: False
    - require:
      - group: arkanosis
      - pkg: term.pkgs
  group.present:
    - gid: 1301

/home/arkanosis/.ssh/authorized_keys:
  file.managed:
    - source: salt://users/authorized_keys_arkanosis
    - user: arkanosis
    - mode: 644
    - makedirs: True
    - require:
      - user: arkanosis

asdp:
  user.present:
    - home: /home/asdp
    - shell: /usr/bin/zsh
    - uid: 1000
    - gid: 1000
    - groups:
      - sudo
    - remove_groups: False
    - require:
      - group: asdp
      - pkg: term.pkgs
  group.present:
    - gid: 1000

/home/asdp/.ssh/authorized_keys:
  file.managed:
    - source: salt://users/authorized_keys_asdp
    - user: asdp
    - mode: 644
    - makedirs: True
    - require:
      - user: asdp

olivier:
  user.present:
    - home: /home/arkanosis
    - shell: /bin/bash
    - uid: 1001
    - gid: 1001
    - groups:
      - sudo
    - remove_groups: False
    - require:
      - group: olivier
  group.present:
    - gid: 1001
