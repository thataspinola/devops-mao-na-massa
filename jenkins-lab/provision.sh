#/bin/bash
echo "inserir librarys"
sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo

sudo yum update -y
sudo yum install epel-release -y
sudo yum install wget git -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo wget https://download.oracle.com/java/17/archive/jdk-17.0.12_linux-x64_bin.rpm
sudo yum install ./jdk-17.0.12_linux-x64_bin.rpm -y
sudo yum install fontconfig java-17-openjdk -y
export JAVA_HOME=/usr/lib/jvm/jdk-17.0.12-oracle-x64
echo 'export JAVA_HOME=/usr/lib/jvm/jdk-17.0.12-oracle-x64' | sudo tee -a /etc/profile
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo service jenkins start

#nstalacao do docker e docker compose
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli  containerd.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
systemctl daemon-reload
systemctl restart docker
sudo usermod -aG docker jenkins

#instalacao do sonar scanner
sudo yum install wget unzip -y
sudo wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.2.1.4610-linux-x64.zip
unzip sonar-scanner-cli-6.2.1.4610-linux-x64.zip -d /opt/
sudo mv /opt/sonar-scanner-6.2.1.4610-linux-x64 /opt/sonar-scanner
chown -R sonar:sonar /opt/sonar-scanner
echo 'export PATH=$PATH:/opt/sonar-scanner/bin' | sudo tee -a /etc/profile
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install nodejs -y
sudo yum install telnet -y