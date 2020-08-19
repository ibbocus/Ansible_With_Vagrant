#!/bin/bash



# The commands required to set up controller vm


# Install Modules
  sudo apt-get update
  sudo apt-get install software-properties-common -y
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt-get install tree -y
  sudo apt-get install ansible -y

# Set up connectivity to web and db

  cd ../..
  sudo su
  echo "[web]
192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant

[db]
192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts

