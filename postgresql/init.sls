postgresql_pkgs:
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
      - pkg: postgresql_pkgs
    - require:
      - pkg: postgresql_pkgs
