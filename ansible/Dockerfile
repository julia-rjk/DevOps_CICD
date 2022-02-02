FROM alpine:3.11
RUN apk add --no-cache openssh-client ansible git
COPY . .
CMD echo $VAULT_PASS > passwd_file  > ~/.ssh/id_rsa \
    chmod 0600 ~/.ssh/id_rsa \
    && ansible-vault decrypt --vault-password-file passwd_file id_rsa \
    && cat id_rsa  \
    && ansible-playbook -i inventories/setup.yml playbook.yml