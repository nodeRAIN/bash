. "lib/utility/needRootUser.sh"

#
# Remove App and clear All file
#
function offlineApp () {
  needRootUser
  
  echo "List App..."
  ls ${nginxDirEnabled}

  echo "App name to make offline:"
  read appName
  if [ "${appName}" != "" -a "${appName}" != "/" -a "${appName}" != "/home" ]; then
    echo 'Make offline App...'
    rm ${nginxDirEnabled}/${appName}
    mv ${supervisorDir}/${appName}.ini ${supervisorDir}/${appName}.ini.off

    echo 'Restart NGINX e SUPERVISOR'
    supervisorctl reload
    sudo /etc/init.d/nginx restart
    /etc/init.d/supervisord restart
  else 
    echo 'Invalid App'
  fi;
  
}
