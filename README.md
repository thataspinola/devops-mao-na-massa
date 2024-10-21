## VAGRANT LAB
sudo apt-get install vagrant
vagrant plugin install vagrant-vbguest --plugin-version 0.21
vagrant init
vagrat up
vagrat up --provision -> quando rodar a primeira vez
vagrant ssh

## ANSIBLE LAB
sudo apt-get install nfs-common nfs-kernel-server
sudo apt install nfs-kernel-server
systemctl status nfs-kernel-server
dpkg -l | grep nfs-kernel-server

vagrant ssh
cat /etc/hosts
sudo vi /etc/ansible/hosts -> control node
ssh-keygen
cd ~/.ssh
vagrant reload --provision - app e dbdb01/app01
ssh vagrant@
ansible-galaxy collection install community.mysql
mvn -o -q -Dexec.executable=echo -Dexec.args='${project.version}' -- rodar deṕois de tentar rodar o ansible-playbook app.yaml

precisa criar o pom na mao dentro do app

## VARIOS
atualizar o Vagrantfile
vagrant global-status --prune
sudo apt-get install nfs-common nfs-kernel-server
vagrant plugin install vagrant-winnfsd
vagrant plugin install  vagrant-nfs_guest
vagrant plugin install vagrant-omnibusvaul