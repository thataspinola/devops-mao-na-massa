#/bin/sh
echo "inserir librarys"
sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo

cat << EOT >> /home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtlid282vuEDXCcOCxdWQRorAzE3vPdN9ywk39I54WOFp0NbKKHmTnjs+yzksJGW6YrHfSK2r2OfdGdWZHGiHreONgoAI6yyaQRkASUz+9KlBxCOkJGtachNQRogkBhTLzMljLc9ZPvzI+wtUa2Bun8OuF+bihmAebmac9U1yGj+0EkroDenDh6wlLuC6u58NyupwEsdp/ZCpLhleicwmsAgXy1TtbRmJyPcy7pWESLa3CEpKfgq1z3RqTsuFhtAThoQ/cqA5FHWD3LywCDTpJABo0VLZX/+gKWYN0gxNs2ZO0GRbl5M8N/Ye/TLXKygT8sj4PKU86Bs4PdyDEXZXv vagrant@control-node
EOT