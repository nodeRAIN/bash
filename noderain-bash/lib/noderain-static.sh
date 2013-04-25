. ${bashroot}/lib/utility/replaceInFile.sh
. ${bashroot}/lib/utility/needRootUser.sh

#
# Function for create a simple HTML static website
#
function createStatic () {
  
  needRootUser

  echo -e 'App name:\n (app name is same of host name ex: noderain.it'
  read host

  echo 'Prepare bin...'
  repoAppDir="${repoDir}/${host}"
  nodeAppDir="${nodeDir}/${host}"
  nginxFileAvailable=${nginxDirAvailable}/${host}
  nginxFileEnabled=${nginxDirEnabled}/${host}
  
  binDir="bin/${host}"
  mkdir $binDir
  tmpSiteAvailableFile="${binDir}/sites"
  tmpRepoDeployDir="${binDir}/repo"
  tmpServerFile="${binDir}/node"

  echo 'Nginx host config creation...'
  cp ${bashroot}/template/static.template ${tmpSiteAvailableFile}
  replaceInFile "${tmpSiteAvailableFile}" "HOST" "${host}"
  replaceInFile "${tmpSiteAvailableFile}" "PATHNODE" "${nodeAppDir}"
 
  mkdir ${tmpRepoDeployDir}
  git init --bare ./${tmpRepoDeployDir}
  cp ${bashroot}/template/post-recive.template ${tmpRepoDeployDir}/hooks/post-receive
  chmod 777 ${tmpRepoDeployDir}/hooks/post-receive
  replaceInFile "${tmpRepoDeployDir}/hooks/post-receive" "PATHNODE" "${nodeAppDir}"
  replaceInFile "${tmpRepoDeployDir}/hooks/post-receive" "HOST" "${host}"

  echo 'Create static...'
  cp ${bashroot}/template/server-static.template ${tmpServerFile}

  echo 'Move bin file in production...'
  mkdir ${repoAppDir}
  mv ${tmpRepoDeployDir}/* ${repoAppDir}
  mkdir ${nodeAppDir}
  mv ${tmpServerFile} ${nodeAppDir}/index.html
  mkdir ${nodeAppDir}/var
  mkdir ${nodeAppDir}/var/log
  mv ${tmpSiteAvailableFile} ${nginxFileAvailable}
  chmod 775 ${repoAppDir}/hooks/post-receive
  
  echo 'Restart NGINX e SUPERVISOR'
  ln -s ${nginxFileAvailable} ${nginxFileEnabled}
  sudo /etc/init.d/nginx restart

  rm -r ${binDir}
  echo 'Done! http://'${host}
}
