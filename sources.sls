{% if grains['os'] == 'Debian' %}
deb http://security.debian.org/ stretch/updates main:
  pkgrepo.managed:
    - dist: stretch/updates
    - file: /etc/apt/sources.list.d/security.list
{% endif %}