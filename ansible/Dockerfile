FROM alpine:3.11
RUN apk add --no-cache openssh-client ansible git
COPY . .
CMD echo $VAULT_PASS >  ~/.vault_pass.txt \ 
    && mkdir ~/.ssh \
    && ansible-vault view --vault-password-file=~/.vault_pass.txt id_rsa > ~/.ssh/id_rsa \
    && chmod 0600 ~/.ssh/id_rsa \
    && cat id_rsa  \
    && ansible-playbook --vault-password-file ~/.vault_pass.txt -i inventories/setup.yml playbook.yml