FROM ubuntu

RUN apt-get update \
    && apt-get install --no-install-recommends -y sudo python3 python3-pip ca-certificates curl gnupg lsb-release git sshpass ssh jq wget

RUN apt-get update \
    && apt-get install wget gpg -y \
    && bash -c 'wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg'\
    && gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint \
    && bash -c 'echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list' \
    && apt-get update \
    && apt-get install -y packer

ENV ANSIBLE_VERSION 2.9.17
RUN apt update; \
    apt install -y gcc python3; \
    apt install -y python3-pip; \
    apt install -y python3-full; \
    apt install -y python3.12-venv; \
    apt clean all

RUN mkdir /root/ansiblevenv; \
    python3 -m venv /root/ansiblevenv; \
    /root/ansiblevenv/bin/pip3 install --upgrade pip; \
    /root/ansiblevenv/bin/pip3 install "ansible==${ANSIBLE_VERSION}"; \
    /root/ansiblevenv/bin/pip3 install ansible

CMD ["/bin/sh"]

