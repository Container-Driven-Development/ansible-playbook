# Ansible Playbook Example

Example playbook 🎁 in docker image, this image is based on https://github.com/Container-Driven-Development/ansible-playbook-base, us base dir or just take it as an inspiration and create completely own [Dockerfile](https://github.com/Container-Driven-Development/ansible-playbook-base/blob/master/Dockerfile). 

Just go ahead and try [run](#run-wrapped-playbook) this example docker image against your playbook it will just print host ansible variables.

## Why?

1. Modern CI ready.
2. Caching - Ansible roles baked in docker image upfront.
3. Reproducible runs with same ansible, python libraries, roles, ansible.cfg, playbooks.

# How does it work?

1. Build docker image including everything needed for playbook to be executed ( ansible, python libraries, roles, ansible.cfg and playbooks )
2. Run this docker image with mounted inventory.yml and id_rsa key from you local or CI
3. Profit 🎩

## Run wrapped playbook

```
$ docker run -it \
-v $HOME/.ssh/id_rsa:/home/ansible/.ssh/id_rsa \
-v /path/to/inventory.yml:/ansible/inventory.yml \
docker.io/devincan/ansible-playbook-example:v0.1 \
-v -e global_test_variable=test
```

## Use wrapped playbook in Gitlab CI

```yaml
ansible-playbook-example:
  stage: example
  image: 
    name: docker.io/devincan/ansible-playbook-example:v0.1
    entrypoint: [""]
  script:
  - /entrypoint.sh
  variables:
    OPTIONS: "-e global_test_variable=test"
```

## Developing playbook

Simply mounting your own playbook into `/ansible-playbook` will allow you to run docker image with your changes without need to rebuild image each time.

```
$ ansible-galaxy install -r /ansible-playbook/requirements.yml -p /ansible-playbook/roles --force

$ docker run -it \
-v $PWD:/ansible-playbook \
-v $HOME/.ssh/id_rsa:/home/ansible/.ssh/id_rsa \
-v /path/to/inventory.yml:/ansible/inventory.yml \
docker.io/devincan/ansible-playbook-example:v0.1 \
-v -e global_test_variable=test
```
