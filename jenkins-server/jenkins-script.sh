#!/bin/bash

# Install AWS CLI
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

#install docker 
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo usermod -aG docker ubuntu #avoid permission error(adding ubuntu user to docker group)
sudo newgrp docker #avoid restarting the server
sudo usermod -aG docker jenkins #adding jenkins user to docker group
sudo newgrp docker #avoid restarting the server
sudo systemctl restart docker
sudo systemctl start docker
sudo systemctl enable docker


#install sonarqube to run on docker
sudo docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community

# Install Trivy
sudo apt-get install -y wget apt-transport-https gnupg
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update -y
sudo apt-get install trivy -y

# Install Java 17
# REF: https://www.rosehosting.com/blog/how-to-install-java-17-lts-on-ubuntu-20-04/
sudo apt update -y
sudo apt install openjdk-17-jdk openjdk-17-jre -y
java -version

# Install Jenkins
# REF: https://www.jenkins.io/doc/book/installing/linux/#debianubuntu

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y                                   # to update package
sudo apt install jenkins -y                          # to install jenkins

sudo systemctl start jenkins                         # to start jenkins service
# sudo systemctl status jenkins                        # to check the status if jenkins is running or not

# Get Jenkins_Public_IP
ip=$(curl ifconfig.me)
port1=8080
port2=9000

# Generate Jenkins initial login password
pass=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

echo "Access Jenkins Server here --> http://$ip:$port1"
echo "Jenkins Initial Password: $pass"
echo
echo "Access SonarQube Server here --> http://$ip:$port2"
echo "SonarQube Username & Password: admin"
