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

# Hiera as ENC
hiera_include('classes')
