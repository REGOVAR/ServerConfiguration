include:
  - system
  - term

{% for user in pillar['users'] %}

{{ user.login }}:
  user.present:
    - home: /home/{{ user.login }}
    - shell: /bin/bash
    - uid: {{ user.id }}
    - gid: {{ user.id }}
{% if user.sudo %}
    - groups:
      - sudo
{% endif %}
    - remove_groups: False
    - require:
      - group: {{ user.login }}
      - pkg: term_pkgs
  group.present:
    - gid: {{ user.id }}

/home/{{ user.login }}/.ssh/authorized_keys:
  file.managed:
    - contents: {{ user.authorized_keys | yaml_encode }}
    - user: {{ user.login }}
    - mode: 644
    - makedirs: True
    - require:
      - user: {{ user.login }}

{% endfor %}
