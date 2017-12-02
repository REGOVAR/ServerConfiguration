postgresql.pkgs:
  pkg.installed:
    - pkgs:
      - postgresql-9.6

postgresql:
  service.running:
    - watch:
      - pkg: postgresql.pkgs
    - require:
      - pkg: postgresql.pkg
