#!/bin/bash
cd /root

echo "## Installing latest Puppet version and dependencies"

rpm -qa | grep puppetlabs-release
if [ "x$?" == "x1" ] ; then
  rpm -ivh https://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm
fi

rpm -qa | grep 'puppet-'
if [ "x$?" == "x1" ] ; then
  yum install -y puppet
fi

rpm -qa | grep 'rubygems'
if [ "x$?" == "x1" ] ; then
  yum install -y rubygems
fi

gem list | grep hiera-file
if [ "x$?" == "x1" ] ; then
  gem install --no-ri --no-rdoc hiera-file
fi

gem list | grep hiera-eyaml
if [ "x$?" == "x1" ] ; then
  gem install --no-ri --no-rdoc hiera-eyaml
fi
