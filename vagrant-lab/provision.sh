#!/usr/bin/env bash
echo "Installing Apache and setting it up..."
echo "sudo sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo"
sudo sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
echo "sudo sed -i s/^#.*baseurl=http/baseurl=https/g /etc/yum.repos.d/*.repo"
sudo sed -i s/^#.*baseurl=http/baseurl=https/g /etc/yum.repos.d/*.repo
echo "sudo sed -i s/^mirrorlist=http/#mirrorlist=https/g /etc/yum.repos.d/*.repo"
sudo sed -i s/^mirrorlist=http/#mirrorlist=https/g /etc/yum.repos.d/*.repo
echo "sudo yum install -y ca-certificates"
sudo yum install -y ca-certificates
echo "sudo update-ca-trust force-enable"
sudo update-ca-trust force-enable
echo "sudo ln -s /etc/ssl/your-cert.pem /etc/pki/ca-trust/source/anchors/your-cert.pem"
sudo ln -s /etc/ssl/your-cert.pem /etc/pki/ca-trust/source/anchors/your-cert.pem
echo "sudo update-ca-trust"
sudo update-ca-trust
echo "sudo yum install -y httpd"
sudo yum install -y httpd
cp -r /vagrant/html/* /var/www/html/
echo "sudo service httpd start"
sudo service httpd start