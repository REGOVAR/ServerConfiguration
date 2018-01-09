webservers.pkgs:
  pkg.installed:
    - pkgs:
      - nginx
      
nginx:
  service.running:
    - watch:
      - pkg: webservers.pkgs
      - file: /etc/nginx/nginx.conf
    - require:
      - pkg: webservers.pkgs

/etc/nginx/site-available/regovar:
  file.managed:
    - source: salt://webservers/regovar
    - user: root
    - mode: 644
      
/etc/nginx/sites-enabled/regovar:
  file.symlink:
    - target: /etc/nginx/sites-available/regovar
    - user: root
