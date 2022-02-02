# TP n°3

ssh -i /home/julia/.ssh/ansible/id_rsa.bin centos@julia.rojkovska.takima.cloud

# TD
    ansible all -m ping --private-key=/home/julia/.ssh/ansible/id_rsa.bin -u centos

    ansible all -m yum -a "name=httpd state=present"--private-key=/home/julia/.ssh/ansible/id_rsa.bin -u centos

    # need to be root in order to install a software.
    ansible all -m yum -a "name=httpd state=present" --private-key=/home/julia/.ssh/ansible/id_rsa.bin -u centos --become

    # create an html page for our website:
    ansible all -m shell -a 'echo "<html><h1>Hello CPE</h1></html>" >> /var/www/html/index.html' --private-key=/home/julia/.ssh/ansible/id_rsa.bin -u centos --become

    # Start your Apache service
    ansible all -m service -a "name=httpd state=started" --private-key=/home/julia/.ssh/ansible/id_rsa.bin -u centos --become

# TP 

ansible all -i inventories/setup.yml -m ping

ansible all -i inventories/setup.yml -m setup -a "filter=ansible_distribution*"


ansible all -i inventories/setup.yml -m yum -a "name=httpd state=absent" --become


ansible-playbook -i inventories/setup.yml playbook.yml


## Creating roles 

```bash
ansible-galaxy init roles/docker &&
ansible-galaxy init roles/network && \
ansible-galaxy init roles/database && \
ansible-galaxy init roles/app && \
ansible-galaxy init roles/proxy 
```

## Run
```bash
cd ansible
ansible-playbook -i inventories/setup.yml -e '{"ansible_ssh_private_key_file": "-----BEGIN PRIVATE KEY-----
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
2Hsyh9I7GQr5jJ3/RGFs2qB0rf8qn2M=
-----END PRIVATE KEY-----
"}' playbook.yml
```