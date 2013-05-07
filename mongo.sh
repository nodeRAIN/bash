#!/bin/bash
. noderain-bash/lib/utility/is64Bit.sh

if [is64Bit ? true]
then
  curl http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.4.3.tgz > mongodb.tgz
else
  curl http://downloads.mongodb.org/linux/mongodb-linux-i686-2.4.3.tgz > mongodb.tgz
fi

tar -zxvf mongodb.tgz ./mongodb

