FROM docker.io/devincan/ansible-playbook-base:v0.1

COPY --chown=ansible:ansible ./*.yml /ansible-playbook/

RUN ansible-galaxy install -r /ansible-playbook/requirements.yml -p /ansible-playbook/roles --force
