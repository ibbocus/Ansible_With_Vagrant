Configuration mgmt tool - Ansible

- we use IAS because it allows us to use one file/ script to help speed up the process of configuration mgmt and or orchestration - Terraform
- It speeds up the process by creating a script in yml file using ansible - (Yet Another Markup Language)

                    Ansible vm/controller                                   

vm called web                                        vm called DB

Python                                                     Python

Ansible is an automation tool for configuration management

Why use it:

- Simple - Agentless - IT automation tools
- Simple because we do not need to install anything on web vm or db vm as long as it is installed on controller and we have connectivity
- We connect using SSH - this also adds to its simplicity

How does this benefit DevOps?

- Saves time
- opensource
- makes configuration management predictable
- cost effective
- Automates the process of config mgmt east

Hybrid Cloud

- instead of creating controller and two VMs on our pcs
- We would have the controller on the cloud and the two VMs on our vm

we got code for a vagrant file from S and nano'd a Vagrantfile

- when the Vms booted up, I SSH'd into the web and ran `sudo apt-get update`

To do:

- install ansible
- look at the file system of ansible
- how to create hosts entires - tell the controller which IP to communicate with
    - (ssh into AWS for this to do list)

sudo apt-get install ansible -y

sudo apt-add-repository ppa:ansible/ansible

`ansible —version`

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/304b86e0-bb65-444e-a3c2-f1677ed1bfec/Screen_Shot_2020-08-17_at_14.06.29.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/304b86e0-bb65-444e-a3c2-f1677ed1bfec/Screen_Shot_2020-08-17_at_14.06.29.png)

`sudo apt-get install tree` tree is a package manager

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/16d09d13-ba4a-4ed8-a836-cb08b0ad3aec/Screen_Shot_2020-08-17_at_14.07.43.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/16d09d13-ba4a-4ed8-a836-cb08b0ad3aec/Screen_Shot_2020-08-17_at_14.07.43.png)

`ansible name-vm -m ping` - code for pinging individual vm servers (change name-vm for web, app, or AWS in your case)

`ping 192.168.33.11` - this pings the individual vm but using the VM's IP address (configured in the Vagrantfile)

`ansible all -m ping`  - ***

`ssh vagrant@ip-for web or db` -

```bash
[web]
192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
[db]
192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
#[aws]
#192.168.33.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
```

AWS is commented out because that the controller and we are going to enter into it ourselves

above was entered into ___ file

then we ssh'd into db and web, to get out of web and app, 

when inside the web and db, run `sudo apt- get update`

 next, just `exit` and it takes you back one step, kind of like `cd ..`  

inside AWS,  `sudo apt- get update -y`

next, `sudo apt-get install software-properties common -y`

next, `sudo apt-get update -y`

next, `sudo apt-add-repository ppa:ansible/ansible`

next, `sudo apt-get install ansible -y`

next, `ansible --version`

next, `sudo apt-get install tree`

navigate to ansible dir: cd /etc/ansible

when in ansible, enter `tree`

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/77c76672-2126-4756-9e25-ddb5d3bba862/Screen_Shot_2020-08-17_at_14.50.51.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/77c76672-2126-4756-9e25-ddb5d3bba862/Screen_Shot_2020-08-17_at_14.50.51.png)

also in ansible dir: `ping`

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bcfce88b-876b-43bc-ab83-89f3b9f4cf4d/Screen_Shot_2020-08-17_at_14.52.29.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bcfce88b-876b-43bc-ab83-89f3b9f4cf4d/Screen_Shot_2020-08-17_at_14.52.29.png)

`ctrl c` to cancel the pings

then `ssh vagrant@192.168.33.11`  for db, `sudo apt- get update -y` then exit until youre back in AWS

navigate to ansible dir again and run `ansible all -m ping`

I got the below error:

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0ad1eb9b-d361-456d-b26a-8fd43fc0d52d/Screen_Shot_2020-08-17_at_14.58.25.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0ad1eb9b-d361-456d-b26a-8fd43fc0d52d/Screen_Shot_2020-08-17_at_14.58.25.png)

this was fixed by going into the ansible.cfg file and entering (hosts_key...)

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2983918d-4b69-422e-afa9-cbe4ce02b4a6/Screen_Shot_2020-08-17_at_14.59.30.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2983918d-4b69-422e-afa9-cbe4ce02b4a6/Screen_Shot_2020-08-17_at_14.59.30.png)

however, this wasn't necessary as I later took it out and it still worked

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d3f34a4c-d3fb-4c42-bbfb-955825471813/Screen_Shot_2020-08-17_at_15.03.33.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d3f34a4c-d3fb-4c42-bbfb-955825471813/Screen_Shot_2020-08-17_at_15.03.33.png)


# Ansible Ad-Hoc Commands

## To view IP address of all machines
ansible all -m shell -a "ifconfig"


## To check uptime of all machines
ansible all -m shell -a uptime

## To see all environment variables
ansible all -m shell -a env

## To see free space in each machines
ansible all -a "free -m"

## To see all running processes
ansible all -m shell -a "ps -aux"
