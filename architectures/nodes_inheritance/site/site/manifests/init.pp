class site {

  include site::general

  if $::role {
    include "site::roles::${::role}"
  }

  if $debug { include site::debug }

}
