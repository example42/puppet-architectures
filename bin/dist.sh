#!/bin/bash
source=$1

function die(){
 echo $1
 exit 1
}

[ $1 ] || die "Provide the file or dir to copy to all the architectures" 
[ -d './architectures' ] || die "Run this command from the puppet-arhitectures basedir"
[ -f "./$source" ] || die "Can't find $source"

for a in $(ls -1 architectures) ; do
  echo "Copying $source to architectures/$a/$source"
  cp -a $source architectures/$a/$source
done
