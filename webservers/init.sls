webservers.pkgs:
  pkg.installed:
    - pkgs:
      - nginx
      
nginx:
  service.running:
    - watch:
      - pkg: webservers.pkgs
    - require:
      - pkg: webservers.pkgs

/etc/nginx/sites-available/regovar:
  file.managed:
    - makedirs: True
    - source: salt://webservers/regovar
    - user: root
    - mode: 644
      
/etc/nginx/sites-enabled/regovar:
  file.symlink:
    - target: /etc/nginx/sites-available/regovar
    - user: root

/etc/nginx/sites-enabled/default:
  file:
    - absent
