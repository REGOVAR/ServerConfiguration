containers_pkgs:
  pkg.installed:
    - pkgs:
{% if grains['oscodename'] in ['stretch', 'xenial'] %}
      - docker-ce
{% else %}
      - docker.io
{% endif %}
