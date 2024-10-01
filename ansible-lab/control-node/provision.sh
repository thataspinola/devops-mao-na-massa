#/bin/sh
echo "sudo sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo"
sudo sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
echo "sudo sed -i s/^#.*baseurl=http/baseurl=https/g /etc/yum.repos.d/*.repo"
sudo sed -i s/^#.*baseurl=http/baseurl=https/g /etc/yum.repos.d/*.repo
echo "sudo sed -i s/^mirrorlist=http/#mirrorlist=https/g /etc/yum.repos.d/*.repo"
sudo sed -i s/^mirrorlist=http/#mirrorlist=https/g /etc/yum.repos.d/*.repo
echo "sudo yum install -y ca-certificates"
sudo update-ca-trust
sudo yum -y install epel-release
echo "inicio da instalacao do ansible"
sudo yum -y install ansible
cat <<EOT >> /etc/hosts
192.168.56.1 control-node
192.168.56.2 app01
192.168.56.3 db01
EOT