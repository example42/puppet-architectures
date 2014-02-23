class site {

  include site::general

  if $::role {
    include "site::roles::role_${::role}"
  }

  if $debug { include site::debug }

}
