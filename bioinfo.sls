include:
  - network

# VEP

/opt/ensembl/vep:
  file.directory:
    - makedirs: True
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    
## VEP cache
curl https://ftp.ensembl.org/pub/release-91/variation/VEP/homo_sapiens_merged_vep_91_GRCh37.tar.gz | tar xz -C /opt/ensembl/vep:
  cmd.run:
    - unless: test -d /opt/ensembl/vep/homo_sapiens_merged_vep_91_GRCh37
    - require:
      - pkg: network.pkgs 
