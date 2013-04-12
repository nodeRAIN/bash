. "lib/utility/needRootUser.sh"

#
# Remove App and clear All file
#
function onlineApp () {
  needRootUser
  
  echo "List App Offline..."
  #TODO: ls ${nginxDirEnabled}

  echo "App name to make offline:"
  read appName
  if [ "${appName}" != "" -a "${appName}" != "/" -a "${appName}" != "/home" ]; then
    echo 'Make online App...'
    ln -s ${nginxDirAvailable}/${appName} ${nginxDirEnabled}/${appName}
    mv ${supervisorDir}/${appName}.ini.off ${supervisorDir}/${appName}.ini

    echo 'Restart NGINX e SUPERVISOR'
    supervisorctl reload
    sudo /etc/init.d/nginx restart
    /etc/init.d/supervisord restart
  else 
    echo 'Invalid App'
  fi;
  
}
