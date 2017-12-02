databases.pkgs:
  pkg.installed:
    - pkgs:
      - postgresql-9.6

postgresql:
  service.running:
    - watch:
      - pkg: databases.pkgs
    - require:
      - pkg: databases.pkg
