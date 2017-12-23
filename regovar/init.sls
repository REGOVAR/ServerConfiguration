include:
  - network
  - postgresql

#Postgresql
regovarpg:
  postgres_user.present:
    - password: regovarpg
    - require:
      - pkg: postgresql.pkgs
  postgres_database.present:
    - owner: regovarpg
    - require:
      - pkg: postgresql.pkgs

#Reference genomes
{% for directory in ['cache', 'downloads', 'files', 'pipelines', 'jobs', 'databases/hg19', 'databases/hg38'] %}
/var/regovar/{{ directory }}:
  file.directory:
    - makedirs: True
    - user: regovar
    - group: regovar
    - dir_mode: 755
    - file_mode: 644    
{% endfor %}

curl http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/refGene.txt.gz | gunzip > /var/regovar/databases/hg19/refGene.txt:
  cmd.run:
    - unless: test -f /var/regovar/databases/hg19/refGene.txt
    - require:
        - pkg: network.pkgs

curl http://hgdownload.soe.ucsc.edu/goldenPath/hg38/database/refGene.txt.gz | gunzip > /var/regovar/databases/hg38/refGene.txt:
  cmd.run:
    - unless: test -f /var/regovar/databases/hg38/refGene.txt
    - require:
        - pkg: network.pkgs

#Regovar
https://github.com/REGOVAR/Regovar.git:
  git.latest:
    - target: /home/regovar/Regovar
    - user: regovar

regovar.requirements:
  pip.installed:
    - requirements:
      - /home/regovar/Regovar/requirements.txt
      - /home/regovar/Regovar/requirements-dev.txt
    
