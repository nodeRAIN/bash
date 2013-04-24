#!/bin/bash
clear
echo '[Wellcome to nodeRAIN server!]'

#Create nodeRAIN user and his home directory
#sudo useradd -d /home/noderain -m -s /bin/bash shell noderain-admin admin
#echo '[Insert nodeRAIN administrator password:]'
#sudo passwd noderain

#TODO: Create admin user who access to git repository

#TODO: CHECK FOR SERVER SERCURITY

#Login with noderain user
#echo '[Login with new user]'
#su noderain-admin

#Start install prerequisite
echo '[Update server]'
sudo apt-get -y update
sudo apt-get -y upgrade
echo '[Server is update!]'

echo '[Install utility tool]'
sudo apt-get install -y rcconf
sudo apt-get install -y build-essential
sudo apt-get install -y libssl-dev
sudo apt-get install -y git-core
echo '[Utility tool Done!]'

echo '[Install nodejs v0.10.3]'
sudo mkdir /home/tmp
cd /home/tmp
wget http://nodejs.org/dist/v0.10.4/node-v0.10.4.tar.gz
tar xzf node-v0.10.4.tar.gz
cd node-v0.10.4
./configure --prefix=/usr
make
sudo make install
echo '[Nodejs Done!]'

echo '[Install NPM]'
cd /home/tmp
git clone http://github.com/isaacs/npm.git
cd npm
sudo make install
echo '[NPM Done!]'

echo '[Install NGINX]'
sudo apt-get install nginx
echo '[NGINX Done!]'

echo '[Install supervisor]'
sudo apt-get install python-setuptools
sudo easy_install supervisor
curl https://raw.github.com/gist/176149/88d0d68c4af22a7474ad1d011659ea2d27e35b8d/supervisord.sh > supervisord
chmod +x supervisord
sudo mv supervisord /etc/init.d/supervisord
sudo rcconf
sudo echo_supervisord_conf > supervisord.conf
sudo mv supervisord.conf /etc/supervisord.conf
#TODO: COPY DEAFULT SUPERVISORD CONF
echo '[Supervisor Done!]'

#TODO: Install node version manager!

#TODO: Install e configure MongoDB as database if needed

#TODO: get that param from a config file
echo '[Create directory]'
mkdir /home/noderain-server
mkdir /home/noderain-repo
mkdir /home/supervisor-conf
echo '[Directory Done!]'

rm -rf /home/tmp/*

#TODO Install BASH noreRAIN
#echo '[Install nodeRAIN bash]'
#echo '[nodeRAIN bash Done!]'

#echo '[Create WebAdmin nodeRAIN]'

#echo '[WebAdmin nodeRAIN Done!]'

#echo '[Your Nodejs server is ready to go!]'

exit
