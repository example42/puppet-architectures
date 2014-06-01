$file_mode = 0755
file { '/tmp/testmode':
  ensure => present,
  mode   => $file_mode,
}
