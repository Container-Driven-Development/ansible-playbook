#!/bin/bash

set -eox pipefail
IFS=$'\n\t'

Y='\033[0;33m'
NC='\033[0m'

mkdir -p ${CDD_PLAY_FOLDER}

if [ "$(ls -A $CDD_DEBUG_FOLDER)" ]; then

    echo -e "${Y}Moving debug files '${CDD_DEBUG_FOLDER}/*' to workdir '${CDD_PLAY_FOLDER}/'${NC}"
    cp -r ${CDD_DEBUG_FOLDER}/* ${CDD_PLAY_FOLDER}/

fi

if [ "$(ls -A $CDD_BAKED_FOLDER)" ]; then

echo -e "${Y}Moving baked files '${CDD_BAKED_FOLDER}/*' to workdir '${CDD_PLAY_FOLDER}/'${NC}"
cp -r ${CDD_BAKED_FOLDER}/* ${CDD_PLAY_FOLDER}/

fi

cd ${CDD_PLAY_FOLDER}
ansible-playbook site.yml --skip-tags="${ANSIBLE_PLAYBOOK_CMD_SKIP_TAGS}" "${ANSIBLE_PLAYBOOK_CMD_OPTIONS}" "${@}"
