#!/bin/bash
# Based on https://github.com/gehel/vagrant-vms/blob/master/vagrant-puppetmaster/init.sh

# Set here the default branch to use for first puppet apply
default_branch='nodeless'
DNS_DOMAIN='example42.com'
DNS_ALT_NAMES="puppet01,puppet02,puppet01.${DNS_DOMAIN},puppet02.${DNS_DOMAIN}"


puppet resource package git ensure=present allow_virtual=true
puppet resource file /etc/puppet/modules ensure=/vagrant/modules force=true
puppet resource file /etc/puppet/manifests ensure=/vagrant/manifests force=true
puppet resource file /etc/puppet/hieradata ensure=/vagrant/hieradata force=true

echo '## librarian-puppet deploy'
export PATH=$PATH:/opt/ruby/bin

gem list | grep librarian-puppet > /dev/null
if [ "x$?" == "x1" ] ; then
  gem install librarian-puppet
fi

cd /vagrant ; librarian-puppet install

# service puppetmaster stop

echo '## CA setup'
# Uncomment to clean up all certificate
# puppet cert clean --all `hostname -f`
[ -f /var/lib/puppet/ssl/ca/ca_pub.pem ] || puppet ca generate --dns-alt-names ${DNS_ALT_NAMES} puppet

# service puppetmaster start
# service puppetmaster stop

echo '## puppet apply'
puppet apply --modulepath=/vagrant/modules:/vagrant/site \
             --hiera_config=/vagrant/hiera.yaml \
             /vagrant/manifests/site.pp

echo '## puppet agent'
sleep 10
puppet agent -t

