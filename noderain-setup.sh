#!/bin/bash
clear
echo '[Wellcome to nodeRAIN server!]'

#Create nodeRAIN user and his home directory 
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
wget http://nodejs.org/dist/v0.10.4/node-v0.10.4.tar.gz
tar xzf node-v0.10.4.tar.gz
cd node-v0.10.4
./configure --prefix=/usr
sudo make install
echo '[###### Done ######]'
sleep 1

echo '[###### Install NPM ######]'
sleep 1
cd /home/tmp
sudo git clone http://github.com/isaacs/npm.git
sudo cd npm
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
sudo curl https://raw.github.com/gist/176149/88d0d68c4af22a7474ad1d011659ea2d27e35b8d/supervisord.sh > supervisord
sudo chmod +x supervisord
sudo mv supervisord /etc/init.d/supervisord
sudo rcconf
sleep 1
echo '[###### Done ######]'

echo '[###### Create directory ######]'
sleep 1
echo -e 'Node application path [/home/noderain-server]: '
read noderainserver-path
echo -e 'Repository path [/home/noderain-repo]: '
read noderainrepo-path
echo -e 'Supervisor conf path [/home/noderain-supervisor]: '
read noderainsupervisor-path

mkdir $noderainserver-path
mkdir $noderainrepo-path
mkdir $noderainsupervisor-path
echo '[###### Done ######]'
sleep 1

echo '[###### Install nodeRAIN bash######]'
sleep 1
sudo git clone https://github.com/nodeRAIN/bash.git ./bashrain
replaceInFile "bashrain/lib/config-server.sh" "PATHNODESERVER" "${noderainserver-path}"
replaceInFile "bashrain/lib/config-server.sh" "PATHNODEREPO" "${noderainrepo-path}"
replaceInFile "bashrain/lib/config-server.sh" "PATHNODESUPERVISOR" "${noderainsupervisor-path}"
sudo mv /bashrain/noderain-bash /bin/noderain-bash
sudo chmod +x /bin/noderaini-bash/noderain.sh
sudo ln -s  /bin/noderain-bash/noderain.sh /usr/bin/noderain
sudo mv bashrain/template/supervisord.conf.template /etc/supervisord.conf
replaceInFile "/etc/supervisord.conf" "PATHINISUPERVISOR" "${noderainsupervisor-path}"
echo '[###### Done ######]'
sleep 1

#TODO: Install node version manager!

#TODO: Install e configure MongoDB as database if needed

#TODO: WEBADMIN noderain
#echo '[Create WebAdmin nodeRAIN]'

#echo '[WebAdmin nodeRAIN Done!]'


rm -rf /home/tmp/*

cd /home

echo 'nodeRAIN is ready to go...have a fun!'

exit
