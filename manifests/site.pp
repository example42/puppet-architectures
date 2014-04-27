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

# Roles are based on hostnames
case $::hostname {
  /^web/: { $role = 'web' }
  /^puppet/: { $role = 'puppetmaster' }
  /^lb/: { $role = 'lb' }
  /^log/: { $role = 'log' }
  /^db/: { $role = 'db' }
  /^el/: { $role = 'el' }
  /^mon/: { $role = 'mon' }
  default: {  }
}

# Env is based on hostname or (sub) domain
if 'devel' in $::fqdn { $env = 'devel' }
elsif 'test' in $::fqdn { $env = 'test' }
elsif 'qa' in $::fqdn { $env = 'qa' }
else { $end = 'prod' }


# In site module is managed our grouping logic
include ::site
