. ${bashroot}/lib/utility/replaceInFile.sh
. ${bashroot}/lib/utility/needRootUser.sh

#
# Function for create a nodejs app
#
function createApp () {
  
  needRootUser

  echo -e 'App name:\n (app name is same of host name ex: noderain.it'
  read host

  #TODO: Check available port
  echo -e 'Node port: '
  read nodeport

  echo 'Prepare bin...'
  repoAppDir="${repoDir}/${host}"
  nodeAppDir="${nodeDir}/${host}"
  supervisorAppFile="${supervisorDir}/${host}.ini"
  nginxFileAvailable=${nginxDirAvailable}/${host}
  nginxFileEnabled=${nginxDirEnabled}/${host}
  
  binDir="${bashroot}/tmp/${host}"
  mkdir $binDir
  tmpSiteAvailableFile="${binDir}/sites"
  tmpRepoDeployDir="${binDir}/repo"
  tmpServerFile="${binDir}/node"
  tmpSupervisorFile="${binDir}/supervisor"

  echo 'Nginx host config creation...'
  cp ${bashroot}/template/node.template ${tmpSiteAvailableFile}
  replaceInFile "${tmpSiteAvailableFile}" "HOST" "${host}"
  replaceInFile "${tmpSiteAvailableFile}" "PORTNODE" "${nodeport}"

  mkdir ${tmpRepoDeployDir}
  git init --bare ${tmpRepoDeployDir}
  cp ${bashroot}/template/post-recive.template ${tmpRepoDeployDir}/hooks/post-receive
  chmod 777 ${tmpRepoDeployDir}/hooks/post-receive
  replaceInFile "${tmpRepoDeployDir}/hooks/post-receive" "PATHNODE" "${nodeAppDir}"
  replaceInFile "${tmpRepoDeployDir}/hooks/post-receive" "HOST" "${host}"

  echo 'Create node...'
  cp ${bashroot}/template/server-nodejs.template ${tmpServerFile}

  echo 'Config supervisor...'
  cp ${bashroot}/template/supervisor.template ${tmpSupervisorFile}
  replaceInFile "${tmpSupervisorFile}" "PATHNODE" "${nodeAppDir}"
  replaceInFile "${tmpSupervisorFile}" "HOST" "${host}"
  replaceInFile "${tmpSupervisorFile}" "PORTNODE" "${nodeport}"

  echo 'Move bin file in production...'
  mkdir ${repoAppDir}
  mv ${tmpRepoDeployDir}/* ${repoAppDir}
  mkdir ${nodeAppDir}
  mv ${tmpServerFile} ${nodeAppDir}/server.js
  mv ${tmpSupervisorFile} ${supervisorAppFile}
  mv ${tmpSiteAvailableFile} ${nginxFileAvailable}
  chmod 775 ${repoAppDir}/hooks/post-receive
  echo 'Restart NGINX e SUPERVISOR'
  supervisorctl reload
  ln -s ${nginxFileAvailable} ${nginxFileEnabled}
  sudo /etc/init.d/nginx restart
  /etc/init.d/supervisord restart

  rm -r ${binDir}
  echo 'For deploy add remote link to your git repository:'
  echo 'git remote add deploy ssh://root/[ipaddress]'${repoAppDir}
  echo 'Done! http://'${host}
}
