postgresql.pkgs:
  pkg.installed:
    - pkgs:
      - postgresql-9.6
    - fromrepo: jessie-backports

postgresql:
  service.running:
    - watch:
      - pkg: postgresql.pkgs
    - require:
      - pkg: postgresql.pkgs
