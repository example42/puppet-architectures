class site::roles::role_web {
  class { 'apache':
  }
  class { 'php':
  }
}
