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
vagrant ssh-config (app01) - pegar o port (2201)
scp -P 2201 vagrant@127.0.01:/opt/notes/target/easy-notes-1.0.0.jar . (app01)
vagrant upload de application.properties, easy-notes, pom e os tar.gz
criar pasta docker-multi-stage > dentro copiar o application.properties e criar o Dockerfile com o conteudo do dockerfilestage
docker build -t devops/notes . > precisa rodar
docker run <imagem>
docker run --name redis-server -d redis
docker logs -f redis-server
docker network ls
docker rm -f redis-server
docker ps -a
docker network create devops
docker run --net devops --name redis-server -d redis
docker run --net devops -p 8080:8081 -d devops/node-app
docker run -i -t -v /root/upload-images:/upload-images ubuntu:16.04

## DOCKER COMPOSE
sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
cp -r node-app/* docker-compose
docker system prune
docker volume prune
docker network remove devops
docker compose up
docker compose down
docker compose up -d

## Docker Swarm
vagrant ssh manager
sudo docker swarm init --advertise-addr 192.168.56.4
sudo docker swarm join --token SWMTKN-1-1f46aen6x0rmhx1nefx2zhtfdidy6xnwy02mtukggj5inrxyf0-379fq3obpd2cqie1tcobngcnd 192.168.56.4:2377
vagrant ssh worker1
vagrant ssh worker2
sudo docker node ls
docker service create --name demo --publish 80:80 nginx
docker service ls
docker service ps demo
docker service scale demo=3