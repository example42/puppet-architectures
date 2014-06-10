# Node with explicit resources
node 'mysql.example.com' {
  package { 'mysql-server':
    ensure => present,
  }
  service { 'mysql':
    ensure => 'running',
  }
}

# Node where classes are included (as provided by the relevant modules)
node 'web.example.com' {
  include common
  include apache
}



