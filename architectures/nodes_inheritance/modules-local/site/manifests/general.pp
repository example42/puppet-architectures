class site::general {

  class { 'resolver':
    dns_servers => $dns_servers,
  }

  class { 'timezone':
    timezone => $timezone,
  }
  include openssh
  include puppet

}
