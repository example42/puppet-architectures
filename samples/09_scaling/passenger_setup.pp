# Passenger setup on RedHat 6
# To test this manifest run, from the directory that contains this file, and the
# used templates:
# puppet apply -t passenger_setup.pp --templatedir ./


# Epel repo
yumrepo { 'epel':
  mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch',
  gpgcheck   => 1,
  enabled    => 1,
  gpgkey     => 'https://fedoraproject.org/static/0608B895.txt',
} ->

# Passenger repo
yumrepo { 'passenger':
  baseurl    => 'http://passenger.stealthymonkeys.com/rhel/$releasever/$basearch',
  mirrorlist => 'http://passenger.stealthymonkeys.com/rhel/mirrors',
  enabled    => 1,
  gpgkey     => 'http://passenger.stealthymonkeys.com/RPM-GPG-KEY-stealthymonkeys.asc',
} ->

# Packages
package { [ 'mod_passenger' , 'httpd' , 'mod_ssl' , 'rubygems']:
  ensure => present,
} ->

package { 'rack':
  ensure => present,
  provider => gem,
} ->

file { '/etc/httpd/conf.d/puppetmaster.conf':
  ensure  => present,
  content => template('puppetmaster.conf'),
} ->

# Rack setup for Passenger
file { ['/etc/puppet/rack','/etc/puppet/rack/public','/etc/puppet/rack/tmp']:
  ensure => directory,
  owner  => 'puppet',
  group  => 'puppet',
} ->

file { '/etc/puppet/rack/config.ru':
  ensure  => present,
  content => template('config.ru'),
  owner   => 'puppet',
  group   => 'puppet',
} ->

service { 'puppetmaster':
  ensure => stopped,
  enable => false,
} ->

service { 'httpd':
  ensure => running,
  enable => true,
  require => Service['puppetmaster'],
}
