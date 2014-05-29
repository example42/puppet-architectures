class site::minimal {

  case $::osfamily {
    redhat: {
      include yum::repo::epel
      include yum::repo::puppetlabs
      package { 'redhat-lsb': ensure => present }
    }
    debian: {
      include apt::repo::puppetlabs
      class { 'apt':
        force_aptget_update => true,
      }
      package { 'lsb-release': ensure => present }
  }
    suse: {
      package { 'lsb': ensure => present }
    }
  }

}
