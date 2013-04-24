#!/bin/bash
clear
echo '[Wellcome to nodeRAIN server!]'

#Create nodeRAIN user and his home directory 
#mkdir /bin/noderain-bash
#sudo useradd -d /home/noderain -g adm -m noderain-adm
#echo '[Insert nodeRAIN administrator password:]'
#sudo passwd noderain-adm

#TODO: Create admin user who access to git repository

#TODO: CHECK FOR SERVER SERCURITY

#Set permission for nodeRAIN user as sudoer
#sudo usermod -a -G sudo noderain-adm

#Login with noderain user
#echo '[Login with new user]'
#su noderain-adm

#Start install prerequisite
echo '[###### Update server ######]'
sleep 1
sudo apt-get -y update
sudo apt-get -y upgrade
echo '[###### Done ######]'
sleep 1

echo '[###### Install utility tool ######]'
sleep 1
sudo apt-get install -y rcconf
sudo apt-get install -y build-essential
sudo apt-get install -y libssl-dev
sudo apt-get install -y git-core
echo '[###### Done ######]'
sleep 1

echo '[###### Install nodejs v0.10.3 ######]'
sleep 1
sudo mkdir /home/tmp
cd /home/tmp
wget http://nodejs.org/dist/v0.10.3/node-v0.10.3.tar.gz
tar xzf node-v0.10.3.tar.gz
cd node-v0.10.3
./configure --prefix=/usr
sudo make install
echo '[###### Done ######]'
sleep 1

echo '[###### Install NPM ######]'
sleep 1
cd /home/tmp
git clone http://github.com/isaacs/npm.git
cd npm
sudo make install
echo '[###### Done ######]'
sleep 1

echo '[###### Install NGINX ######]'
sleep 1
sudo apt-get -y install nginx
echo '[###### Done ######]'

echo '[###### Install supervisor ######]'
sleep 1
sudo apt-get -y install python-setuptools
sudo easy_install supervisor
curl https://raw.github.com/gist/176149/88d0d68c4af22a7474ad1d011659ea2d27e35b8d/supervisord.sh > supervisord
chmod +x supervisord
sudo mv supervisord /etc/init.d/supervisord
sudo rcconf
sudo echo_supervisord_conf > supervisord.conf
sudo mv supervisord.conf /etc/supervisord.conf
sleep 1

#TODO: COPY DEAFULT SUPERVISORD CONF
echo '[###### Done ######]'

#TODO: Install node version manager!

#TODO: Install e configure MongoDB as database if needed

#TODO: get taht param from a config file
echo '[###### Create directory ######]'
sleep 1
mkdir /home/noderain-server
mkdir /home/noderain-repo
mkdir /home/supervisor-conf
echo '[###### Done ######]'
sleep 1

rm -rf /home/tmp/*

#TODO Install BASH noreRAIN
#echo '[Install nodeRAIN bash]'
#echo '[nodeRAIN bash Done!]'

#echo '[Create WebAdmin nodeRAIN]'

#echo '[WebAdmin nodeRAIN Done!]'

#echo '[Your Nodejs server is ready to go!]'

cd /home

exit
