class site::general {

  class { '::resolver':
    dns_servers => [ '8.8.8.8' , '8.8.4.4' ],
  }

  class { '::openssh': }

  class { '::timezone':
    timezone => 'Europe/Rome', 
  }

  class { '::puppet':
    server => 'puppet',
  }

  class { '::stack::logstash':
    syslog_server         => '10.42.42.15',
    elasticsearch_server  => '10.42.42.151', 
    syslog_install        => true,
    logstash_install      => $::role ? {
      'log'   => true,
      default => false,
    },
    kibana_install        => $::role ? {
      'web'   => true,
      default => false,
    },
    elasticsearch_install => $::role ? {
      'el'    => true,
      default => false,
    },
  }

}
