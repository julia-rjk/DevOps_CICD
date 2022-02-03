FROM alpine:3.11

# Preparing environment
RUN apk add ansible gcc python3-dev libc-dev libffi-dev openssl-dev openssh-keygen
RUN pip3 install --upgrade paramiko
ENV ANSIBLE_HOST_KEY_CHECKING=False

COPY . .
# The vault pass is put into a local file
# Then we create the .ssh folder
# Then we are decrypting the ssh key and copying into the .ssh folder
# Attributing the right permissions
# Transform the ssh key into a well formatted key
# Running ansible playbook
CMD echo $VAULT_PASS >  ~/.vault_pass.txt \ 
    && mkdir ~/.ssh \
    && ansible-vault view --vault-password-file=~/.vault_pass.txt id_rsa > ~/.ssh/id_rsa \
    && chmod 0600 ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa  \
    && ssh-keygen -p -m PEM -f ~/.ssh/id_rsa \
    && ansible-playbook -i inventories/setup.yml playbook.yml