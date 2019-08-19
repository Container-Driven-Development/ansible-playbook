FROM alpine:3.10.1

WORKDIR /ansible

# Setup base system + ansible
RUN addgroup -S ansible && \
    adduser -S ansible -G ansible && \
    apk upgrade \
        --no-cache && \
    apk add \
        curl \
        libressl \
        ca-certificates \
        ansible \
        git \
        openssh-client \
        --no-cache && \
    pip3 install --upgrade pip && \
    pip3 install dnspython && \
    pip3 install netaddr && \
    pip3 install jmespath && \
    mkdir /ansible-playbook-base/ /ansible-playbook && \
    chown -R ansible:ansible /ansible /ansible-playbook-base/ /ansible-playbook

COPY entrypoint.sh /

USER ansible

COPY ansible.cfg /ansible-playbook-base/

ENTRYPOINT ["/entrypoint.sh"]
