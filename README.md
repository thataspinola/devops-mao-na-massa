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
redis-app: sqp_dba794703c7752fdb1e64430590bc74636a4a47e3
sonar-scanner \
  -Dsonar.projectKey=redis-app \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=sqp_dba794703c7752fdb1e64430590bc74636a4a47e

## JENKINS
ps aux | grep java
sudo service jenkins start
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
baixar os plugins do git no jenkins e o sonar scanner plugin
configurar o servidor do sonar e depois o sonar scaner
configuraçao sonarqube: nome: sonar-server / server: 192.168.56.7:9000 / e o secrettext
colocar o sonar-scanner para nao baixar e colocar o caminho como /opt/sonar-scanner
docker volume create --name nexus-data
docker run -d -p 8091:8081 -p 8123:8123 --name nexus -v nexus-data:/nexus-data sonatype/nexus3

## nexus > no jenkins
docker exec -it nexus bash
cat /nexus-data/admin.password
sign no nexus user:admin /senha:8a1b5667-d2f8-4c1d-8104-5f7ed0676c47 -> depois troca a senha do nexus
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
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
su -s /bin/bash jenkins
sudo su - jenkins
usermod -s /bin/bash jenkins
su -s /bin/bash jenkins
vi ~/.kube/config > copiar o conteudo do k3s.yaml
kubectl get po
kubectl get namespaces
kubectl delete namespace devops
kubectl create namespace devops
na pasta redis-app > git tag -a v1.0.0 -m "Release inicial"
na pasta redis-app > git push origin v1.0.0


## K3
sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo
yum update -y
curl -sfL https://get.k3s.io | sh -s - --cluster-init --tls-san 192.168.56.9 --node-ip 192.168.56.9 --node-external-ip 192.168.56.9
sudo cat /var/lib/rancher/k3s/server/node-token
K10eb5770aa283aa7a9f299e0f3ef585c575440518d43b0655657b51a0d622fc93d::server:e9f4dbb346f917b0f47f544f0c68c5dc
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.9:6443 K3S_TOKEN=K10eb5770aa283aa7a9f299e0f3ef585c575440518d43b0655657b51a0d622fc93d::server:e9f4dbb346f917b0f47f544f0c68c5dc sh -
service k3s status
kubectl get nodes
yum install git unzip telnet net-tools -y
vi /etc/profile
alias k=kubectl
git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens
yum install bash-completion -y
echo 'source <(kubectl completion bash | sed s/kubectl/k/g)' >> ~/.bashrc
cat ~/.bashrc
kubectl completion bash > /etc/bash_completion.d/kubectl
cat /etc/bash_completion.d/kubectl
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -F __start_kubectl k' >> ~/.bashrc
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/bin/k3s:$PATH
kubectl get services
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
kubectl version --client
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config/k3s.yaml
kubectl --kubeconfig ~/.kube/config/k3s.yaml get pods --all-namespaces
vi /etc/rancher/k3s/registries.yaml
sudo k3s kubectl get node
service k3s restart
mkdir redis-app > cd redis-app > vi redis.yaml
kubectl apply -f redis.yaml
kubectl get deployment
kubectl describe deployment redis-server
kubectl get po
kubectl get po -o wide
kubectl describe svc redis-server
vi redis-app.yaml
kubectl create namespace devops
kubens devops
kubectl apply -f redis-app.yaml
kubectl get ingress

## PROMETHEUS/GRAFANA
vagrant rsync > sincronizar arquivos
tar -xvf node_exporter-1.8.2.linux-amd64.tar.gz
mv node_exporter-1.8.2.linux-amd64 /opt/
cd /opt/node_exporter-1.8.2.linux-amd64/
ls -lha
nohup ./node_exporter &
tail - nohup.out
yum install telnet -y
docker run -d -p 9090:9090 -v /vagrant/prometheus.yaml:/etc/prometheus.yaml prom/prometheus
docker run -d -p 3000:3000 --name grafana grafana/grafana:latest