#
# Remove App an clear All file 
#
function destroyApp () {
  echo 'This operation remove all file and is unrecoverable.\nContinue: (y/N)'
  read continueOperation
  
  if [${continueOperation} != 'y' -o ${continueOperation} != 'Y']; then
    exit 1;  
  fi;

  echo -e 'Host name to remove: '
  read host

  repoAppDir="${repoDir}/${host}"
  nodeAppDir="${nodeDir}/${host}"
  supervisorAppFile="${supervisorDir}/${host}.ini"
  nginxAppFileAvailable="${nginxDirAvailable}/${host}"
  nginxAppFileEnabled="${nginxDirEnabled}/${host}"

  echo 'Remove directory and file...'
  rm -rf ${repoAppDir} 
  rm -rf ${nodeAppDir}
  rm -f ${supervisorAppFileDir}
  rm -f ${nginxAppFileAvailable}
  rm -f ${nginxAppFileEnabled}

  echo 'Restart NGINX e SUPERVISOR'
  supervisorctl reload
  sudo /etc/init.d/nginx restart
  /etc/init.d/supervisord restart
}

