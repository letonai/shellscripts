#!/bin/bash
#Setup new ubuntu machine
if [ ! "$USER" = "root" ]
then
    echo "Run with sudo"
    exit 1
fi

echo "Setting up for user $USER"
echo "Removing previous docker installs"
#Remove previous docker instalations
apt-get remove docker docker-engine docker.io containerd runc
apt-get update
echo "installing vim"
apt -y install vim
echo "Installing dependencies"
apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

#add key for docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
#Add repo
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
#Install Docker
apt-get -y install docker-ce docker-ce-cli containerd.io
#install python pip
apt install -y python-pip
#Download and install docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#Add execution permition
chmod +x /usr/local/bin/docker-compose
#create a link to user/bin
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
#Get user that ran sudo from pid
FPID=`ps -eaf | grep sudo | grep -v grep | awk '{print $3}'`
USER=`ps -eaf | grep $FPID | grep -v $USER | awk '{print $1}'`
#Configure user do skip passwd using SUDO
echo "setting up no password for sudo and adding user $USER to docker group"
sed -i 's/\(%sudo.*)\) /\1 NOPASSWD:/g' /etc/sudoers
#Add user to group docker
usermod -aG docker $USER

echo "Restart session before continue"