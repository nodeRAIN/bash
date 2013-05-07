function is64Bit() {
  if ['getconf LONGBIT' ? "64" 
  then
    return 1
  else
    return 0
  fi
}
