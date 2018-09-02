include:
  - containers
  - network
  - postgresql

#Regovar users
regovar:
  user.present: #Linux user
    - home: /home/regovar
    - uid: 2000
    - gid: 2000
    - remove_groups: False
    - groups:
      - docker
    - require:
      - group: regovar
      - pkg: containers_pkgs
  group.present: #Linux user group
    - gid: 2000
  postgres_user.present: #Postgresql user
    - password: regovar
    - require:
      - pkg: postgresql_pkgs

#Reference genomes
{% for directory in ['cache', 'downloads', 'files', 'pipelines', 'jobs', 'databases'] %}
/var/regovar/{{ directory }}:
  file.directory:
    - makedirs: True
    - user: regovar
    - group: regovar
    - dir_mode: 755
    - file_mode: 644
{% endfor %}


#Regovar
#FIXME
https://github.com/REGOVAR/Regovar.git:
  git.latest:
    - target: /home/regovar/Regovar
    - user: regovar

regovar_pkgs:
  pkg.installed:
    - pkgs:
      - libssl-dev
      #required to make pip install work

regovar.requirements:
  pip.installed:
    - require:
      - pkg: regovar_pkgs
    - bin_env: '/usr/bin/pip3'
    - requirements:
      - /home/regovar/Regovar/requirements.txt

regovar.makeinstall:
  cmd.run:
    - name: |
        sudo -u regovar make init_config
        sed -i 's/^\(\s*HOST_P\s*=\s*"\)[^"]*\(".*\)/\1{{ pillar['public_hostname'] }}:{{ pillar['public_port'] }}\2/' ../regovar/config.py
        sed -i 's/^\(\s*DATABASE_NAME\s*=\s*"\)[^"]*\(".*\)/\1regovar\2/' ../regovar/config.py
        sed -i 's/^\(\s*DATABASE_HOST\s*=\s*"\)[^"]*\(".*\)/\1localhost\2/' ../regovar/config.py
        sed -i 's/^\(\s*PRIVATE_KEY32\s*=\s*"\)[^"]*\(".*\)/\1'"$(openssl rand -base64 40 | tr -d "=+/" | cut -c1-32)"'\2/' ../regovar/config.py
        make download_databases
        sudo -u postgres make create_database
        sudo -u regovar make fill_database
        make download_hpo
        sudo -u regovar make install_hpo
    - require:
      - user: regovar
    - cwd: /home/regovar/Regovar/install
    - unless: test -f ../regovar/config.py
    - env:
      - LC_ALL: en_US.UTF-8

