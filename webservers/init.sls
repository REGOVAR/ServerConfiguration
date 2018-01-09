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

/etc/nginx/site-available:
  file.managed:
    - source: salt://webservers/regovar
    - user: root
    - mode: 644
    - require:
      - user: root
