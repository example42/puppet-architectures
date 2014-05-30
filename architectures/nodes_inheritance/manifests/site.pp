# Debug mode.
# $debug = true

# Site wide resource defaults
File {
  owner => 'root',
  group => 'root',
  mode  => '0644',
}

Exec {
  path => '/bin:/usr/bin:/sbin:/usr/sbin',
}

# Default node
node default {
  $role = 'default'

  # Infrastructure parameters ( May stay here and be managed by inheritance or be set in site module)
  $dns_servers = [ '8.8.8.8' , '8.8.4.4' ]
  $timezone = 'Europe/Rome'
}

# Environments
node prod inherits default {
  $env = 'prod'
}
node qa inherits default {
  $env = 'qa'
}
node dev inherits default {
  $env = 'dev'
}
node test inherits default {
  $env = 'test'
}

# Nodes
node /^web\d+\.example42\.com$/ inherits prod {
  $role = 'web'
  include site
}
node 'puppet.example42.com' inherits prod {
  $role = 'puppet'
  include site
}
node /^lb\d+\.example42\.com$/ inherits prod {
  $role = 'lb'
  include site
}
node 'log.example42.com' inherits prod {
  $role = 'log'
  include site
}
node /^db\d+\.example42\.com$/ inherits prod {
  $role = 'db'
  include site
}
node /^el\d+\.example42\.com$/ inherits prod {
  $role = 'el'
  include site
}
node 'mon.example42.com' inherits prod {
  $role = 'mon'
  include site
}

# Sample test node
node /^web\d+\.test\.example42\.com$/ inherits test {
  $role = 'web'
  include site
}
