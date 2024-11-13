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

## SONARQUBE
ps aux | grep java
sudo service sonar status
admin - admin
redis-app: sqp_02a99a920b2e02ca69abe6f7024bba04b6698693
sonar-scanner \
  -Dsonar.projectKey=redis-app \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=sqp_02a99a920b2e02ca69abe6f7024bba04b6698693

## JENKINS
ps aux | grep java
sudo service jenkins start
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
baixar os plugins do git no jenkins e o sonar scanner plugin
configurar o servidor do sonar e depois o sonar scaner
configuraçao sonarqube: nome: sonar-serve / server: 192.168.56.7:9000 / e o secrettext
colocar o sonar-scanner para nao baixar e colocar o caminho como /opt/sonar-scanner
docker volume create --name nexus-data
docker run -d -p 8091:8081 -p 8123:8123 --name nexus -v nexus-data:/nexus-data sonatype/nexus3

## nexus
docker exec -it nexus bash
cat /nexus-data/admin.password
sign no nexus user:admin /senha:1b4920f6-1a70-4390-8c12-773910401f71 -> depois troca a senha do nexus
criar um novo usuario para o jenkins no nexus
criar um novo repositorio docker hosted > name docker-repo e http port 8123
cd /var/lib/jenkins/workspace
cp -r redis-app /root/
cd /root/redis-app
docker build -t devops/app .
docker login localhost:8123 > usuario jenkins e senha
docker login -u jenkins -p 123456 localhost:8123 (salva a senha)
docker tag devops/app:latest localhost:8123/devops/app
docker push localhost:8123/devops/app
configurar variaval de ambiente no jenkins > dash > gerir o jenkins > system > enviroment variables > adicionar: name NEXUS_URL valor localhost:8123
criar credencial global  user e password colocando a credencial do nexus (login jenkins + senha)

## K3
sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo
curl -sfL https://get.k3s.io | sh -s - --cluster-init --tls-san 192.168.56.9 --node-ip 192.168.56.9 --node-external-ip 192.168.56.9
service k3s status
kubectl get nodes
yum install git unzip telnet net-tools -y
vi etc/profile
alias k=kubectl
git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens
yum install bash-completion -y
echo 'source <(kubectl completion bash | sed s/kubectl/k/g)' >> ~/.bashrc
cat ~/.bashrc
kubectl completion bash > /etc/bash_completion.d/kubectl
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -F __start_kubectl k' >> ~/.bashrc
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/bin/k3s:$PATH
kubectl get services