#!/bin/bash
. lib/config-server.sh

case "${1}" in
  create) source lib/noderain-create.sh
          createApp
          ;;
  destroy) source lib/noderain-destroy.sh
           destroyApp
           ;;
  offline) source lib/noderain-offline.sh
           offlineApp
           ;;
  *) echo 'Invalid option!'
esac

echo 'Done!'
