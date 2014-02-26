#!/bin/bash
# Based on https://github.com/gehel/vagrant-vms/blob/master/vagrant-puppetmaster/init.sh
export PATH=$PATH:/opt/ruby/bin

gem list | grep r10k > /dev/null
if [ "x$?" == "x1" ] ; then
  gem install r10k
fi

r10k deploy environment --config /vagrant/r10k.yaml 

service puppetmaster stop
puppet cert clean --all `hostname -f`
puppet ca generate --dns-alt-names ${PUPPET_EXTERNAL_NAME},${PUPPET_INTERNAL_NAME} `hostname -f`

#service puppetmaster start
service puppetmaster stop

echo 'puppet run to ensure basic configuration'
puppet apply --modulepath=/etc/puppet/environments/production/modules:/etc/puppet/environments/production/site \
             --hiera_config=/etc/puppet/environments/production/hiera.yaml \
              /etc/puppet/environments/production/manifests/site.pp

echo 'full puppet run to ensure server is completely created'
sleep 30
puppet agent -t

