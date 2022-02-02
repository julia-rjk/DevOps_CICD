# TP n°3

# Questions 
## 3-1 Document your inventory and base commands
```yaml
all:
  vars:
    ansible_user: centos # L'utilisateur 
    ansible_ssh_private_key_file: id_rsa # Fichier où on retrouve la clé ssh
  children:
    prod:
      hosts: julia.rojkovska.takima.cloud # Adresse du serveur
```

## 3-2 Document your playbook
```yaml
- hosts: all
  gather_facts: false
  become: yes
  roles: # Utilisation des roles, cela executera leurs tasks
    - docker
    - network
    - database
    - app
    - frontend
    - proxy
```

## 3-3 Document your docker_container tasks configuration.
Exemple : 

```yaml
# tasks file for roles/network
- name: Create a network
  docker_network:
    name: app-network # Nom du réseau qu'on crée

```

```yaml
# tasks file for roles/app
- name: Run app - backend
  docker_container: 
    name: backend # Nom de l'image
    image: jrocpe/tp-devops-cpe-backend:latest # Repository où on récupère l'image
    networks:
      - name: "app-network" # Nom du réseau qu'on utilise
```

## Continuous deployment
*https://misfra.me/2019/10/using-ansible-with-github-actions/*

- Voir .github/workflows/.ansible.yml & Voir ./ansible/Dockerfile
- Ca fonctionne 

# Commandes

## TD
    ansible all -m ping --private-key=/home/julia/.ssh/ansible/id_rsa.bin -u centos

    ansible all -m yum -a "name=httpd state=present"--private-key=/home/julia/.ssh/ansible/id_rsa.bin -u centos

    # need to be root in order to install a software.
    ansible all -m yum -a "name=httpd state=present" --private-key=/home/julia/.ssh/ansible/id_rsa.bin -u centos --become

    # create an html page for our website:
    ansible all -m shell -a 'echo "<html><h1>Hello CPE</h1></html>" >> /var/www/html/index.html' --private-key=/home/julia/.ssh/ansible/id_rsa.bin -u centos --become

    # Start your Apache service
    ansible all -m service -a "name=httpd state=started" --private-key=/home/julia/.ssh/ansible/id_rsa.bin -u centos --become

## TP 
ssh -i /home/julia/.ssh/ansible/id_rsa.bin centos@julia.rojkovska.takima.cloud
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
ansible-galaxy init roles/proxy && \
ansible-galaxy init roles/frontend
```

## Run
```bash
cd ansible
ansible-playbook -i ansible/inventories/setup.yml ansible/playbook.yml
```