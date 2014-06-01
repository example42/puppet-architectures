class site::minimal {

  case $::osfamily {
    redhat: {
      # include yum::repo::epel
      # include yum::repo::puppetlabs
      package { 'redhat-lsb': ensure => present }
    }
    debian: {
      # include apt::repo::puppetlabs
      package { 'lsb-release': ensure => present }
  }
    suse: {
      package { 'lsb': ensure => present }
    }
  }

}
