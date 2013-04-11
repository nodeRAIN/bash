#!/bin/bash

case "${1}" in
  create) source lib/noderain-create.sh
          createApp
          ;;
  destroy) source lib/noderain-destroy.sh
           destroyApp
           ;;
  *) echo 'Invalid option!'
esac
