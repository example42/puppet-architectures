class site::debug {

  file { '/tmp/puppet.debug':
    ensure   => present,
    loglevel => debug,  # this is needed to avoid it being logged and reported on every run
    content  => inline_template('<%= scope.to_yaml %>'),
  }

}
