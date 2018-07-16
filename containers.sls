include:
  - sources

containers.pkgs:
  pkg.installed:
    - pkgs:
{% if grains['osrelease'] in ['stretch', 'xenial'] %}
      - docker-ce
{% elif grains['osrelease'] == 'bionic' %}
      - docker.io
{% endif %}
