#/bin/sh
echo "inserir librarys"
sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo

echo "inicio da instalacao do epel-release"
yum -y install epel-release

echo "instalacao do wget"
yum -y install wget

echo "instalacao do apache"
yum -y install httpd

echo "inicio da instalacao do ansible"
yum -y install ansible
cat <<EOT >> /etc/hosts
192.168.56.1 control-node
192.168.56.2 app01
192.168.56.3 db01
EOT