#!/bin/bash
cd /root

case "$1" in
  original) puppetsuffix='' ;;
  latest) puppetsuffix='' ;;
  *) puppetsuffix="-${1}.el6" ;;
esac

echo "## Installing latest Puppet version and dependencies"

if [ "x$1" != "xoriginal" ] ; then
  rpm -qa | grep puppetlabs-release >/dev/null 2>&1
  if [ "x$?" == "x1" ] ; then
    rpm -ivh https://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm >/dev/null 2>&1
  fi
fi

rpm -qa | grep "^puppet${puppetsuffix}" >/dev/null 2>&1
if [ "x$?" == "x1" ] ; then
  yum install -y puppet$puppetsuffix >/dev/null 2>&1
fi

rpm -qa | grep 'rubygems' >/dev/null 2>&1
if [ "x$?" == "x1" ] ; then
  yum install -y rubygems >/dev/null 2>&1
fi

gem list | grep hiera-file >/dev/null 2>&1
if [ "x$?" == "x1" ] ; then
  gem install --no-ri --no-rdoc hiera-file
fi

gem list | grep hiera-eyaml 2>&1>/dev/null
if [ "x$?" == "x1" ] ; then
  gem install --no-ri --no-rdoc hiera-eyaml
fi

puppet resource host puppet ip=10.42.42.10 >/dev/null 2>&1

