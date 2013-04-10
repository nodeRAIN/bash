#!/bin/bash
repoDir="/home/repo-deployer/"
nodeDir="/home/node-server/"

#
# Funzione di sostituzione di una stringa in un file
# Parametri: nomefile, oldString, newString
#
function replaceInFile() {
        echo "replaceInFile ${1} di ${2} con ${3}"
        if [ -z "${1}" -o -z "${2}" -o -z "${3}" ]; then
                echo -e "Errore in replaceInFile: lista parametri errata.\nImpossibile eseguire la chiamata replaceInFile(${1}, ${2}, ${3}).";
                exit 1;
        fi;
        if [ -e ${1} ]; then
		sed -e "s#${2}#${3}#g" ${1} > /tmp/crea_virtualhost_tmp
		mv /tmp/crea_virtualhost_tmp ${1}
        else
                echo -e "Errore in replaceInFile: file non trovato. Impossibile aprire il file ${1}.";
                exit 1;
        fi;
}


echo -e 'Host name: '
read host

#TODO: Check port availablde port
echo -e 'Node port: '
read nodeport

echo -e 'Nginx port: '
read nginxport

echo 'Prepare bin...'
binDir="bin/${host}"
prodDir="${nodeDir}${host}"
mkdir $binDir
tmpSiteAvailableDir="${binDir}/sites"
tmpRepoDeployDir="${binDir}/repo"
tmpServerApp="${binDir}/node"
tmpSupervisor="${binDir}/supervisor"

echo 'Nginx host config creation...'
mkdir ${tmpSiteAvailableDir}
cp template/node.template ${tmpSiteAvailableDir}/${host}
replaceInFile "${tmpSiteAvailableDir}/${host}" "HOST" "${host}"
replaceInFile "${tmpSiteAvailableDir}/${host}" "PORTNODE" "${nodeport}"
replaceInFile "${tmpSiteAvailableDir}/${host}" "PORTNGINX" "${nginxport}"

mkdir ${tmpRepoDeployDir}
git init --bare ./${tmpRepoDeployDir}
cp template/post-recive.template ${tmpRepoDeployDir}/hooks/post-receive
chmod 777 ${tmpRepoDeployDir}/hooks/post-receive
replaceInFile "${tmpRepoDeployDir}/hooks/post-receive" "PATHNODE" "${prodDir}"

echo 'Create node...'
mkdir ${tmpServerApp}
cp template/server-nodejs.template ${tmpServerApp}/server.js

echo 'Config supervisor...'

echo 'Move bin file in production...'

echo 'Restart NGINX e SUPERVISOR'

echo 'Done! http://'${host}
