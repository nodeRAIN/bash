#
# Choose available service for noderain
#
function serviceUp () {
  needRootUser
  
  echo "List of available service:"
  echo "'countly' - http://count.ly Mobile Analytics"
  
  read serviceId

  case "${serviceId}" in
    countly) source ${bashroot}/lib/serviceup/countly.sh
      countly
      ;;
  *) echo 'Invalid service!'
esac
}