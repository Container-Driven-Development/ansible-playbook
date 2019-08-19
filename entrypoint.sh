#!/bin/sh

echo "Moving base files ( /ansible-playbook-base/* ) to workdir ( $PWD )"
cp -r /ansible-playbook-base/* .

echo "Moving playbook files ( /ansible-playbook/* ) to workdir ( $PWD )"
cp -r /ansible-playbook/* .

echo "Setting ANSIBLE_CONFIG to $PWD/ansible.cfg to prevent issues on CI with other workdir than /ansible"
export ANSIBLE_CONFIG=$PWD/ansible.cfg

echo "Executing ansible-playbook site.yml --skip-tags=\"$SKIP_TAGS\" $OPTIONS $@"
ansible-playbook site.yml --skip-tags="$SKIP_TAGS" $OPTIONS "$@"
