FROM alpine:3.12.0

ARG ANSIBLE_VERSION=2.9.9-r0

ENV ANSIBLE_SSH_CONTROL_PATH /dev/shm/cp%%h-%%p-%%r
ENV ANSIBLE_INVENTORY inventory.yml
ENV ANSIBLE_FORCE_COLOR True
ENV ANSIBLE_HOST_KEY_CHECKING False
ENV ANSIBLE_COMMAND_WARNINGS False
ENV ANSIBLE_RETRY_FILES_ENABLED False
ENV ANSIBLE_GATHERING explicit
ENV ANSIBLE_PRIVATE_ROLE_VARS True
ENV ANSIBLE_REMOTE_USER root
ENV ANSIBLE_ROLES_PATH /ansible/baked/roles
ENV ANSIBLE_CALLBACK_WHITELIST profile_tasks
ENV ANSIBLE_SSH_RETRIES 3
ENV ANSIBLE_PYTHON_INTERPRETER /usr/bin/python3

ENV ANSIBLE_PLAYBOOK_CMD_OPTIONS "-v"
ENV ANSIBLE_PLAYBOOK_CMD_SKIP_TAGS ""

ENV CCD_USER ansible
ENV CCD_GROUP ansible
ENV CDD_BASE_FOLDER /ansible
ENV CDD_BAKED_FOLDER ${CDD_BASE_FOLDER}/baked
ENV CDD_DEBUG_FOLDER ${CDD_BASE_FOLDER}/debug
ENV CDD_PLAY_FOLDER ${CDD_BASE_FOLDER}/play

# Setup base system + ansible
RUN addgroup -S ${CCD_GROUP} && \
    adduser -S ${CCD_USER} -G ${CCD_GROUP}

RUN apk upgrade \
        --no-cache && \
    apk add \
        ansible=${ANSIBLE_VERSION} \
        py-pip \
        bash \
        curl \
        libressl \
        ca-certificates \
        git \
        openssh-client \
        sshpass \
        --no-cache

COPY requirements.txt /var/run/requirements.txt

# RUN pip3 install --upgrade pip && \
#     pip3 install --no-cache-dir -r /var/run/requirements.txt

RUN mkdir -p ${CDD_DEBUG_FOLDER} ${CDD_BAKED_FOLDER} ${CDD_PLAY_FOLDER} && chown -R ${CCD_USER}:${CCD_GROUP} ${CDD_BASE_FOLDER}

COPY entrypoint.sh /

USER ${CCD_USER}

WORKDIR ${CDD_PLAY_FOLDER}

ENTRYPOINT ["/entrypoint.sh"]
