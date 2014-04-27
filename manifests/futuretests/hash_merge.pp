$config_hash = { 
  doc_root => '/my_docs',
}

$config_default_hash = {
  servername => $::fqdn,
  doc_doot   => '/docs',
}

$real_config_hash = $config_default_hash + $config_hash

notice $real_config_hash
