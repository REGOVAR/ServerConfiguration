sources_pkgs:
  pkg.installed:
    - pkgs:
      - apt-transport-https

{% if grains['oscodename'] == 'stretch' %}
deb http://security.debian.org/ stretch/updates main:
  pkgrepo.managed:
    - dist: stretch/updates
    - file: /etc/apt/sources.list.d/security.list

deb https://download.docker.com/linux/debian stretch stable:
  pkgrepo.managed:
    - dist: stretch
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 0EBFCD88
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: containers_pkgs
{% endif %}

{% if grains['oscodename'] == 'xenial' %}
deb https://download.docker.com/linux/ubuntu xenial stable:
  pkgrepo.managed:
    - dist: xenial
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 0EBFCD88
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: containers_pkgs
{% endif %}
