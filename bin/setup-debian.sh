#!/bin/bash

cd /root

if [ "x$1" == "xlatest" ] ; then
  if [ ! -f puppetlabs-release-precise.deb ] ; then 
    echo "## Installing Puppetlabs repository"
    wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb 2>&1>/dev/null 
    dpkg -i puppetlabs-release-precise.deb 2>&1>/dev/null
    apt-get update 2>&1>/dev/null
  fi
fi

echo "## Installing Puppet and its dependencies"
dpkg -s puppet 2>&1>/dev/null || apt-get update 2>&1>/dev/null ; apt-get install puppet -y 2>&1>/dev/null
dpkg -s rubygems 2>&1>/dev/null || apt-get install rubygems -y 2>&1>/dev/null
dpkg -s git 2>&1>/dev/null || apt-get install git -y 2>&1>/dev/null

gem list | grep hiera-file 2>&1>/dev/null
if [ "x$?" == "x1" ] ; then
  gem install --no-ri --no-rdoc hiera-file
fi

gem list | grep hiera-eyaml 2>&1>/dev/null
if [ "x$?" == "x1" ] ; then
  gem install --no-ri --no-rdoc hiera-eyaml
fi

puppet resource host puppet ip=10.42.42.10 2>&1>/dev/null

