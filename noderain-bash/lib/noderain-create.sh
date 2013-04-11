source "lib/utility/replaceInFile.sh"
source "lib/utility/needRootUser.sh"

#
# Function for create a nodejs app
#
function createApp () {
  
  needRootUser

  echo -e 'Host name: '
  read host

  #TODO: Check port availablde port
  echo -e 'Node port: '
  read nodeport

  echo 'Prepare bin...'
  repoAppDir="${repoDir}/${host}"
  nodeAppDir="${nodeDir}/${host}"
  supervisorAppFile="${supervisorDir}/${host}.ini"
  nginxFileAvailable=${nginxDirAvailable}/{$host}
  nginxFileEnabled=${nginxDirEnabled}/${host}
  
  binDir="bin/${host}"
  mkdir $binDir
  tmpSiteAvailableFile="${binDir}/sites"
  tmpRepoDeployDir="${binDir}/repo"
  tmpServerFile="${binDir}/node"
  tmpSupervisor="${binDir}/supervisor"

  echo 'Nginx host config creation...'
  cp template/node.template ${tmpSiteAvailableDir}
  replaceInFile "${tmpSiteAvailableDir}" "HOST" "${host}"
  replaceInFile "${tmpSiteAvailableDir}" "PORTNODE" "${nodeport}"

  mkdir ${tmpRepoDeployDir}
  git init --bare ./${tmpRepoDeployDir}
  cp template/post-recive.template ${tmpRepoDeployDir}/hooks/post-receive
  chmod 777 ${tmpRepoDeployDir}/hooks/post-receive
  replaceInFile "${tmpRepoDeployDir}/hooks/post-receive" "PATHNODE" "${nodeDir}"
  replaceInFile "${tmpRepoDeployDir}/hooks/post-receive" "HOST" "${host}"

  echo 'Create node...'
  cp template/server-nodejs.template ${tmpServerFile}

  echo 'Config supervisor...'
  cp template/supervisor.template ${tmpSupervisor}
  replaceInFile "${tmpSupervisor}" "PATHNODE" "${nodeDir}"
  replaceInFile "${tmpSupervisor}" "HOST" "${host}"
  replaceInFile "${tmpSupervisor}" "PORTNODE" "${nodeport}"

  echo 'Move bin file in production...'
  mkdir ${repoAppDir}
  mv ${tmpRepoDeployDir} ${repoAppDir}
  mkdir ${nodeAppDir}
  mv ${tmpServerFile} ${nodeAppDir}/server.js
  mv ${tmpSupervisor}/${host}.ini ${supervisorAppFile}
  mv ${tmpSiteAvailableDir}/${host} ${nginxFileAvailable}

  echo 'Restart NGINX e SUPERVISOR'
  supervisorctl reload
  ln -s ${nginxFileAvailable} ${nginxFileEnabled}
  sudo /etc/init.d/nginx restart
  /etc/init.d/supervisord restart

  rm -r ${binDir}
  echo 'Done! http://'${host}
}
