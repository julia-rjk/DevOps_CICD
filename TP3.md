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
ansible-playbook -i inventories/setup.yml playbook.yml
```