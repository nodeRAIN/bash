# nodeRAIN

## Create a nodeJS server has become simple!

* NGINX as http proxy
* Nodejs as http server
* Supervisor as nodejs proc runner
* Git for deploy
* and finally bash command to easy manage server!

(thanks to http://cuppster.com/2011/05/12/diy-node-js-server-on-amazon-ec2/ who inspire me)

(more info are coming on http://noderain.it)

## Getting Started

To setup the server

1. get bash setup
  
  `sudo mkdir /home/tmp`
  
  `cd /home/tmp`
  
  `sudo wget https://github.com/nodeRAIN/bash/archive/master.zip .`
  
  `sudo apt-get install unzip` 
  
  `sudo unzip master.zip`

  `sudo chmod 775 /home/tmp/bash-master/noderain-setup.sh`

2. login as root

  `su root`

3. launch the script and follow the instructions
  
  `/home/tmp/bash-master/noderain-setup.sh`

4. wait a few minutes!

## Create your first nodejs app with noderain bash

1. create new app with bash
   
   `noderain create`

2. add remote link on your git repository to the server
  
   `git remote add deploy ssh://user@your.static.ip/home/noderain-repo/name.app`

3. push your code!
  
   `git push deploy`

## Script is ready for

Ubuntu 12.10 X64 Server
Debian 6 32bit (thanks to Emanuele Tido pt.linkedin.com/pub/emanuele-tido/23/1b3/b77/)
