include:
  - system
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

asdp.zshconf:
  cmd.run:
    - name: |
        mkdir zshconf
        cd zshconf
        git init
        git remote add -f origin https://github.com/Arkanosis/Arkonf.git
        git config core.sparseCheckout true
        echo "zsh" >> .git/info/sparse-checkout
        git pull origin master
    - cwd: /home/asdp
    - runas: asdp
    - unless: test -d /home/asdp/zshconf

/home/asdp/.zshrc:
  file.symlink:
    - target: /home/asdp/zshconf/zsh/.zshrc
    - user: asdp

/home/asdp/.zsh:
  file.symlink:
    - target: /home/asdp/zshconf/zsh/.zsh
    - user: asdp

olivier:
  user.present:
    - home: /home/olivier
    - shell: /usr/bin/zsh
    - uid: 1001
    - gid: 1001
    - groups:
      - sudo
    - remove_groups: False
    - require:
      - group: olivier
      - pkg: term.pkgs
  group.present:
    - gid: 1001
