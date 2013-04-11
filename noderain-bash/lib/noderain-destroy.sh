#
# Remove App and clear All file 
#
function destroyApp () {
  echo "List App..."
  ls ${nginxDirEnabled}

  echo "App name to destroy:"
  read appName
  
  echo -e "This operation remove all file and is unrecoverable.\nContinue (y/N):"
  read continueOperation

  if [ "${continueOperation}" == "y" -o "${continueOperation}" == "Y" ]; then
    
    if [ "${appName}" != "" -a "${appName}" != "/" -a "${appName}" != "/home" ]; then 
      repoAppDir="${repoDir}/${appName}"
      nodeAppDir="${nodeDir}/${appName}"
      supervisorAppFile="${supervisorDir}/${appName}.ini"
      nginxAppFileAvailable="${nginxDirAvailable}/${appName}"
      nginxAppFileEnabled="${nginxDirEnabled}/${appName}"

      echo 'Remove directory and file...'
      rm -rf ${repoAppDir} 
      rm -rf ${nodeAppDir}
      rm -f ${supervisorAppFile}
      rm -f ${nginxAppFileAvailable}
      rm -f ${nginxAppFileEnabled}

      echo 'Restart NGINX e SUPERVISOR'
      supervisorctl reload
      sudo /etc/init.d/nginx restart
      /etc/init.d/supervisord restart  
    else
      echo "Invalid App"
    fi;
  fi;
}

