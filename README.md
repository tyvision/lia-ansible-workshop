# LIA Ansible workshop
Large Installation Administration Workshop

## Contents
This repo contains ansible playbook for deploying `Nginx` in reverse-proxy mode + `Let's Encrypt` in order to create an `https` connection to the jupyter notebook. All services are launched using `docker-compose`. 

## Pre-Requisities
(on remote host)
- docker
- docker-compose 

You can install them using `sh.sh` script from this repo home dir. (it will be inserted into ansible playbook in future work, or you can try it by yourself)

(on localhost)
- ansible
```
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
```

## HowTo launch
Before you start: go to the `inventory.txt` file and add info about your host to the jupyter group. 
File `roles/docker/vars/main.yml` is encrypted using `ansible-vault`. Thus, you need to specify and option during `ansible-playbook` launch.

Also, you can change values of the vars/main.yml file by decrypting it. 
```
ansible-vault decrypt roles/docker/vars/main.yml --vault-password-file=pass.txt 
```
After changes took place, you can again encrypt it. By the way, you can easily change the password and place it wherever you prefer.
```
ansible-vault encrypt roles/docker/vars/main.yml --vault-password-file=pass.txt 
```

Finally, you can launch playbook using this command

```
ansible-playbook -i inventory.txt --vault-password-file pass.txt --private-key=<your-ssh-key-location> play.yml
```

## Outcomes
Here we cover this features from ansible
- playbooks creation
- inventory files management
- jinja2 templates
- ansible-vault