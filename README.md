# Ansible Playbook Base docker image

Base docker image for 🎁 ansible playbooks

## Usage

See [./example](./example) folder

1. Creare own [Dockerfile](./example/Dockerfile) based on this docker image `docker.io/devincan/ansible-playbook-base:v0.4`
2. Add your playbooks
3. Build
4. Run


## Why?

1. 🦾 Modern CI ready.
2. 🏺 Caching - Ansible roles baked in docker image upfront.
3. 🎡 Reproducible runs with same ansible, python libraries, roles, ansible.cfg, playbooks.
4. ⚗️ When you want to run playbooks on Windows

# How does it work?

1. Build docker image including everything needed for playbook to be executed ( Ansible, Python libraries, roles and playbooks )
2. Run this docker image with mounted inventory.yml and id_rsa key from you local or CI
3. Profit 🎩

## What exaclty base image does?

1. Setup ansible senzible defaults

    - [ANSIBLE_INVENTORY](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBLE_INVENTORY) `inventory.yml`
    - [ANSIBLE_FORCE_COLOR](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBLE_FORCE_COLOR) `True`
    - [ANSIBLE_HOST_KEY_CHECKING](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBLE_HOST_KEY_CHECKING) `False`
    - [ANSIBLE_COMMAND_WARNINGS](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBLE_COMMAND_WARNINGS) `False`
    - [ANSIBLE_RETRY_FILES_ENABLED](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBLE_RETRY_FILES_ENABLED) `False`
    - [ANSIBLE_GATHERING](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBLE_GATHERING) `explicit`
    - [ANSIBLE_PRIVATE_ROLE_VARS](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBLE_PRIVATE_ROLE_VARS) `True`
    - [ANSIBLE_REMOTE_USER](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBLE_REMOTE_USER) `pddevops`
    - [ANSIBLE_ROLES_PATH](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBLE_ROLES_PATH) `roles`
    - [ANSIBLE_CALLBACK_WHITELIST](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBLE_CALLBACK_WHITELIST) `profile_tasks`
    - [ANSIBLE_SSH_RETRIES](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBLE_SSH_RETRIES) `10`
    - [ANSIBLE_SSH_CONTROL_PATH](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBLE_SSH_CONTROL_PATH) `/dev/shm/cp%%h-%%p-%%r`
    - [ANSIBE_OPTIONS](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#envvar-ANSIBE_OPTIONS) `"-v"`

2. Add [entrypoint.sh](entrypoint.sh)

   This entrypoint will copy baked roles, playbooks and other files from `/ansible/baked` to `/ansible` workdir. Then it will run site.yml playbook.

3. Add essential Python/Ansible dependencies listed in [requirements.txt](./requirements.txt) 
