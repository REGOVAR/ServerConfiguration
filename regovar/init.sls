{% for directory in ['cache', 'downloads', 'files', 'pipelines', 'jobs', 'databases/hg19', 'databases/hg38'] %}
/var/regovar/{{ directory }}:
  file.directory:
    - makedirs: True
    - user: regovar
    - group: regovar
    - dir_mode: 755
    - file_mode: 644    
{% endfor %}
