#/bin/sh
echo "inserir librarys"
sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo

echo "instalacao do wget"
yum -y install wget

cat << EOT >> /home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiLjh2H9lusTLpqnl91ZqANos9V/s9xYXb70n1U9AKBz6VJ0PXoCocqbKfqZXEElWDDc0CZJa7eArgv3shxuer8oPoNsD0gr0I56yp2rV/lBzCOYwWq9VB+iHm02/VLyGXNKs9AYbK2sRWZZro2eyfygTGIVmOU5RP1bJOmsfUzWIFPwfPLv4OIa5TZZAd54DjQhK00Rk7Er47rm+NbW0u3gYl1ZXpQP2FsqKyY0qbdXyLUNR+pLuNQXqd4DamZgPmqieGIyRwrniPXh0JO2MIZx3eUq24kDHMBG7nypka/2zLlii9fjC0vc24EaNBeJ/E1PnrqtSrrTp2H58ogjbb vagrant@control-node
EOT