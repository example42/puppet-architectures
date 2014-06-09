#!/bin/bash

cd /root
case "$1" in
  original) puppetsuffix='' ;;
  latest) puppetsuffix='' ;;
  *) puppetsuffix="=${1}puppetlabs1" ;;
esac

if [ "x$1" != "xoriginal" ] ; then
  if [ ! -f puppetlabs-release-precise.deb ] ; then 
    echo "## Installing Puppetlabs repository"
    wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb >/dev/null 2>&1
    dpkg -i puppetlabs-release-precise.deb >/dev/null 2>&1
    apt-get update >/dev/null 2>&1
  fi
fi

echo "## Installing Puppet and its dependencies"
dpkg -s puppet >/dev/null 2>&1 || apt-get update >/dev/null 2>&1 ; apt-get install puppet$puppetsuffix puppet-common$puppetsuffix -y >/dev/null 2>&1
dpkg -s rubygems >/dev/null 2>&1 || apt-get install rubygems -y >/dev/null 2>&1
dpkg -s git >/dev/null 2>&1 || apt-get install git -y >/dev/null 2>&1

gem list | grep hiera-file >/dev/null 2>&1
if [ "x$?" == "x1" ] ; then
  gem install --no-ri --no-rdoc hiera-file
fi

gem list | grep hiera-eyaml >/dev/null 2>&1
if [ "x$?" == "x1" ] ; then
  gem install --no-ri --no-rdoc hiera-eyaml
fi

puppet resource host puppet ip=10.42.42.10 >/dev/null 2>&1

