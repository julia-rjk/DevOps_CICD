FROM alpine:3.11
RUN apk add ansible gcc python3-dev libc-dev libffi-dev openssl-dev openssh-keygen
RUN pip3 install --upgrade paramiko
ENV ANSIBLE_HOST_KEY_CHECKING=False

COPY . .
CMD echo $VAULT_PASS >  ~/.vault_pass.txt \ 
    && mkdir ~/.ssh \
    && ansible-vault view --vault-password-file=~/.vault_pass.txt id_rsa > ~/.ssh/id_rsa \
    && chmod 0600 ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa  \
    && ssh-keygen -p -m PEM -f ~/.ssh/id_rsa \
    && ansible-playbook --vault-password-file ~/.vault_pass.txt -i inventories/setup.yml playbook.yml