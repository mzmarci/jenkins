 #!/bin/bash 
sudo yum update -y
sudo yum install -y git
sudo amazon-linux-extras install docker -y
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on
sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo yum install wget
sudo amazon-linux-extras install java-openjdk11
sudo amazon-linux-extras install epel -y
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins -y
sudo service jenkins start
sudo usermod -aG docker jenkins
sudo service jenkins restart
sudo yum install pip -y
sudo pip install --user ansible
sudo yum -y python3-pip
sudo yum install python3 -y
sudo pip3 install boto3
sudo yum install https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip
unzip terraform_1.4.6_linux_amd64.zip
sudo mv terraform /usr/bin
sudo yum install git java-11-amazon-corretto-devel.x86_64 -y
