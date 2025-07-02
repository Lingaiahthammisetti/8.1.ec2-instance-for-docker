#!/bin/bash
yum install yum-utils -y 
yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo 
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 
systemctl start docker 
systemctl enable docker 
usermod -aG docker ec2-user 

echo "******* Resize EBS Storage ***Start*************"
# ec2 instance creation request for Docker expense project
# =============================================
# RHEL-9-DevOps-Practice
# t3.micro
# allow-everything
# 50 GB

lsblk
sudo growpart /dev/nvme0n1 4 
sudo lvextend -l +50%FREE /dev/RootVG/rootVol 
sudo lvextend -l +50%FREE /dev/RootVG/varVol 
sudo xfs_growfs / 
sudo xfs_growfs /var 
echo "******* Resize EBS Storage ***Done***********"

echo "************************"
systemctl status docker
echo "************************"


git clone https://github.com/Lingaiahthammisetti/8.11.expense-docker-for-k8s.git
cd 8.11.expense-docker-for-k8s
docker build -t debug:v1.1 .
docker images
docker tag debug:v1.1 lingadevops/debug:v1.1
docker login -u lingadevops -p Welcome#100
docker push lingadevops/debug:v1.1
