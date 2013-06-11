#!/bin/bash
bashroot="/bin/noderain-bash"

. ${bashroot}/lib/config-server.sh

case "${1}" in
  create) source ${bashroot}/lib/noderain-create.sh
          createApp
          ;;
  static) source ${bashroot}/lib/noderain-static.sh
          createStatic
          ;; 
  destroy) source ${bashroot}/lib/noderain-destroy.sh
           destroyApp
           ;;
  offline) source ${bashroot}/lib/noderain-offline.sh
           offlineApp
           ;;
  serviceup) source ${bashroot}/lib/noderain-serviceup.sh
             serviceUp
             ;;
  *) echo 'Invalid option!'
esac

echo 'Done!'
