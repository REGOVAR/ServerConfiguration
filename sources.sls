{% if grains['osrelease'] == 'stretch' %}
deb http://security.debian.org/ stretch/updates main:
  pkgrepo.managed:
    - dist: stretch/updates
    - file: /etc/apt/sources.list.d/security.list

deb https://download.docker.com/linux/debian stretch stable:
  pkgrepo.managed:
    - dist: stretch
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 0EBFCD88
    - require_in:
      - pkg: docker-ce
{% endif %}

{% if grains['osrelease'] == 'xenial' %}
deb https://download.docker.com/linux/ubuntu xenial stable:
  pkgrepo.managed:
    - dist: xenial
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 0EBFCD88
    - require_in:
      - pkg: docker-ce
{% endif %}
