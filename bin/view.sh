#!/bin/bash
source=$1

function die(){
 echo $1
 exit 1
}

[ $1 ] || die "Provide the file to show for all the architectures" 
[ -d './architectures' ] || die "Run this command from the puppet-architectures basedir"
[ -f "./$source" ] || die "Can't find $source"

for a in $(ls -1 architectures) ; do
  echo "## Showing $source to architectures/$a/$source"
  cat architectures/$a/$source
done
