#!/bin/bash

vagrant up

scp -r playbooks/ vagrant@192.168.33.12:/home/vagrant/
ssh vagrant@192.168.33.12 << EOF

export ANSIBLE_HOST_KEY_CHECKING=False
ansible web -m copy -a "src=/home/vagrant/app dest=/home/vagrant"

sudo apt-get install sshpass -y
sudo apt-get install software-properties-common -y
sudo apt-get install tree -y
sudo apt-add-repository--yes--update ppa:ansible/ansible;
sudo apt-get install ansible -y


sudo su
cd /etc/ansible
echo "[web]
192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts
echo "[db]
192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts
echo "[aws]
192.168.33.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts

sudo apt-get update -y
sudo apt-get upgrade -y
sshpass -p "vagrant" ssh -o stricthostkeychecking=no vagrant@192.168.33.11
sudo apt-get install sshpass -y

exit



exit
EOF


ssh vagrant@192.168.33.10 << EOF

sudo apt-get update -y
sudo apt-get upgrade -y
sshpass -p "vagrant" ssh -o stricthostkeychecking=no vagrant@192.168.33.10
sudo apt-get install sshpass -y

exit

EOF

# SSH into controller
ssh vagrant@192.168.33.12 << EOF

export ANSIBLE_HOST_KEY_CHECKING=False
# Copy file into our web vm
ansible web -m copy -a "src=/home/vagrant/app dest=/home/vagrant"
# THIS RUNS OUR PLAYBOOK!!
ansible-playbook playbooks/app_db_playbook.yml

exit

EOF
