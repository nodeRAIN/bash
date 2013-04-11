function needRootUser() {
  if [ "$(whoami)" != "root" ]; then
    echo 'Warning: run script as root user!'
    exit 1;
  fi;
}

