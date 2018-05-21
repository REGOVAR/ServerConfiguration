include:
  - network
  - postgresql

#Regovar users
regovar:
  user.present: #Linux user
    - home: /home/regovar
    - uid: 2000
    - gid: 2000
    - remove_groups: False
    - require:
      - group: regovar
  group.present: #Linux user group
    - gid: 2000
  postgres_user.present: #Postgresql user
    - password: regovar
    - require:
      - pkg: postgresql.pkgs

#Reference genomes
{% for directory in ['cache', 'downloads', 'files', 'pipelines', 'jobs', 'databases/hg19', 'databases/hg38'] %}
/var/regovar/{{directory}}:
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

regovar.requirements:
  pip.installed:
    - bin_env: '/usr/bin/pip3'
    - requirements:
      - /home/regovar/Regovar/requirements.txt
      - /home/regovar/Regovar/requirements-dev.txt

regovar.makeinstall:
  cmd.run:
    - name: |
        make init_config
        sed -i 's/^\(\s*DATABASE_NAME\s*=\s*"\)[^"]\+\(".*\)/\1regovar\2/' config.py
        make download_refgene
        make setup_database
        make install_hpo
    - cwd: /home/regovar/Regovar/install
    - runas: regovar
    - unless: test -f config.py

