#
# Funzione di sostituzione di una stringa in un file
# Parametri: nomefile, oldString, newString
#
function replaceInFile() {
  if [ -z "${1}" -o -z "${2}" -o -z "${3}" ]; then
    echo -e "Errore in replaceInFile: lista parametri errata.\nImpossibile eseguire la chiamata replaceInFile(${1}, ${2}, ${3}).";
    exit 1;
  fi;
  if [ -e ${1} ]; then
    sed -e "s#${2}#${3}#g" ${1} > /tmp/rif.tmp
    mv /tmp/rif.tmp ${1}
  else
    echo -e "Errore in replaceInFile: file non trovato. Impossibile aprire il file ${1}.";
    exit 1;
  fi;
}
