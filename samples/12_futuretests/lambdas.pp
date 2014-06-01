$sites = ['example42.com','lab42.it','google.com']
each($sites) |$my_site| {

  file { "/tmp/$my_site":
    ensure => present,
  }
}
