# Sample Nodes declarations for network devices

# Juniper Network device
# - https://github.com/puppetlabs/puppet-netdev-stdlib 
# - https://github.com/Juniper/puppet-netdev-stdlib-junos

node 'switch02.example42.lan' {

  # A single etdev_devic resource must be present
  netdev_device { $hostname: }

  # Sample configuration of an interface
  netdev_interface { 'ge-0/0/0':
    admin => down,
    mtu   => 2000,
  }

  # Sample configuration of a VLAN
  netdev_vlan { 'vlan102':
    vlan_id     => '102',
    description => 'Public network',
  }

  # Configuration of an access port without VLAN tag
  netdev_l2_interface { 'ge-0/0/0':
     untagged_vlan => Red
  }

  # Configuration of a trunk port with multiple VLAN tags
  # And untagged packets go to 'native VLAN'
  netdev_l2_interface { 'xe-0/0/2':
     tagged_vlans  => [ Red, Green, Blue ],
     untagged_vlan => Yellow
  }

  # Configuration of Link Aggregation ports (bonding) 
  netdev_lag { 'ae0':
     links => [ 'ge-0/0/0', 'ge-1/0/0', 'ge-0/0/2', 'ge-1/0/2' ],
     lacp  => active,
     minimum_links => 2
  }
}


# Cisco onePK
# - http://puppetlabs.com/presentations/managing-cisco-devices-using-puppet
node 'switch01.example42.lan' {
  # Definition of the Device, needed for each device
  cisco_device { 'switch01.example42.lan':
    ensure => present,
  }

   Configuration of a VLAN on an access interface 
  cisco_interface { 'Ethernet1/5':
    switchport  => access,
    access_vlan => 1000,
  }

  # Configuration of a VLAN
  cisco_vlan { '1000':
    ensure    => present,
    vlan_name => 'DMZ',
    state     => active,
  }
}



# VCenter (Windows)
# - https://github.com/puppetlabs/puppetlabs-vcenter

node 'vcenter.example42.com {
  class vcenter {
    media             => 'e:\\',
    jvm_memory_option => 'M',
  }
  
  vc_folder { '/prod':
    ensure => present,
  }
  
  vc_datacenter { [ '/prod/uk', '/prod/it' ]:
    ensure => present,
  }
  
  vc_cluster { [ '/prod/uk/fe', '/prod/it/fe' ]:
    ensure => present,
  }
  
  vc_host { '10.42.20.11':
    ensure   => 'present',
    username => 'root',
    password => 'password',
    tag      => 'fe',
  }
  
}


