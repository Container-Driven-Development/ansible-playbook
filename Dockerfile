FROM alpine:3.10.1

WORKDIR /ansible

# Setup base system + ansible
RUN groupadd -g 999 ansible && \
    useradd -r -u 999 -g ansible ansible && \
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
    pip3 install jmespath

COPY ansible.cfg /ansible-playbook-base/
COPY entrypoint.sh /

USER ansible

ENTRYPOINT ["/entrypoint.sh"]
