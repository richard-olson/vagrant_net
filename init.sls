{% for tenant in salt['netbox.filter']('tenancy','tenants') %}
{{pillar['vagrant']['output_folder']}}/{{tenant.slug}}/Vagrantfile:
    file.managed:
        - source: salt://vagrant_net/vagrant_net_template.jinja
        - user: {{pillar['vagrant']['username']}}
        - group: {{pillar['vagrant']['username']}}
        - mode: 644
        - template: jinja
        - replace: True
        - makedirs: True
{% endfor %}
