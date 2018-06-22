postgresql.pkgs:
  pkg.installed:
    - pkgs:
{% if grains['os'] == 'Debian' %}       
      - postgresql-9.6
{% else %}
      - postgresql
{% endif %}

postgresql:
  service.running:
    - enable: True
    - watch:
      - pkg: postgresql.pkgs
    - require:
      - pkg: postgresql.pkgs
