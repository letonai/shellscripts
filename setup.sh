#!/bin/bash
#Setup new ubuntu machine
if [ ! "$USER" = "root" ]
then
    echo "Run as root"
    exit 1
fi


echo "Setting up for user $USER"
echo "Removing previous docker installs"
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

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io
echo "setting up no password for sudo and adding user $USER to docker group"
sed -i 's/\(%sudo.*)\) /\1 NOPASSWD:/g' /etc/sudoers
usermod -aG docker $USER

echo "Restart session before continue"