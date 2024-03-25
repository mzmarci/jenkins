#!/bin/bash
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user

#Make docker auto-start
sudo chkconfig docker on

sudo yum install -y git

# Install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm — import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo usermod -a -G docker jenkins

sudo yum install pip -y
sudo pip install --user ansible
sudo yum -y python3-pip
sudo yum install python3 -y
sudo pip3 install boto3
sudo yum install https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip"
unzip terraform_1.4.6_linux_amd64.zip"
sudo mv terraform /usr/bin"
sudo yum install git java-11-amazon-corretto-devel.x86_64 -y

#Reboot to verify it all loads fine on its own.
sudo reboot
