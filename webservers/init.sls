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
