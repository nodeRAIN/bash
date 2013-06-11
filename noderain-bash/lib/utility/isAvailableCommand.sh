#
# Check if a command is available 
#
function isAvailableCommand() {
  if !(command -v ${1} >/dev/null) 
  then
    return 0;
  else
  	return 1;
  fi
}
