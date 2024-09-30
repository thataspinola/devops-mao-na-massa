## VAGRANT LAB
sudo apt-get install vagrant
vagrant plugin install vagrant-vbguest --plugin-version 0.21
vagrant init
vagrat up
vagrat up --provision -> quando rodar a primeira vez
vagrant ssh

## ANSIBLE LAB
sudo apt-get install nfs-common nfs-kernel-server

atualizar o Vagrantfile
vagrant global-status --prune