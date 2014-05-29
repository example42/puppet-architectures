class site::roles::web {
  class { '::apache':
  }
  class { '::php':
  }
}
