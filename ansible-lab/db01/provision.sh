#/bin/sh
echo "inserir librarys"
sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo

cat << EOT >> /home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGBVhFq+RApg0rrsG+R0hsM/4lotQaUL6iyjJwOXwbJ1rlLp9PJ0jKp5fcDZoshY90mu2ru8jzest3A9GV9EwxrKv1kjGAioBwuQX84p29sDvjmDcL6yy6f6rcECDi+xVgpYfILKS7zuc0MczK4Qv+m2Du+k6MQK8tfoULLAJfdTkwyf3ydgK8LLBHPOctpAgncziEq1o9wrVEy1URwAvDNZafUmetkZDJGAfUr7aKwT5WCxc+fa/QoJ/mtrLZ62OvNzNpjJnak5rLpyH98dfWDvb/BlvHfhqMolqr1hZLCFZPa7A4WwV2KzkT237n02YRr9dfC3d6TncL9zpVz9Mj vagrant@control-node
EOT