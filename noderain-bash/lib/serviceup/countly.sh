. ${bashroot}/lib/config-create.sh

#
# Insall countly
#
function countly () {
  needRootUser
  
  echo -e '[###### Now install countly service. For more info visit http://count.ly ######]'

  echo -e '[###### Install pre requisites: ######]'
  echo -e '[###### Imagemagick ######]'
  apt-get -y install imagemagick

  echo -e '[###### Sendmail ######]'
  apt-get -y install sendmail  
  
  echo -e '[###### Create application ######]'
  serviceAppDir="${serviceDir}/count.ly"
  mkdir $serviceAppDir
  git clone git://github.com/Countly/countly-server.git $serviceAppDir

  

}