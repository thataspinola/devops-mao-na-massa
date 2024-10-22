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
ansible-galaxy role install geerlingguy.mysql

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
sudo yum update
sudo yum install java-1.8.0-openjdk-devel
cat /etc/profile.d/maven.sh
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export M2_HOME=/opt/apache-maven-3.1.0
export MAVEN_HOME=/opt/apache-maven-3.1.0
export PATH=${M2_HOME}/bin:${PATH}

sudo chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh


## VARIOS
atualizar o Vagrantfile
vagrant global-status --prune
sudo apt-get install nfs-common nfs-kernel-server
vagrant plugin install vagrant-winnfsd
vagrant plugin install  vagrant-nfs_guest
vagrant plugin install vagrant-omnibusvaul

## LAB DOCKER
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose