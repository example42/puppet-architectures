# Based on https://github.com/patrickdlee/vagrant-examples/blob/master/example7/Vagrantfile

# Select the OS you want to use (see boxes list below)
# default_os = 'Centos64_64'
default_os = 'Ubuntu1204_64'

# Define your domain
domain = 'example42.com'

# Default ram (can be overriden per node)
default_ram = '128'

# Default number of cpu  (can be overriden per node)
default_cpu = '1'

# Default puppetmode (How Puppet is run: agent, needs the puppet VM running, apply (default) is masterless)
mode = 'apply'

# Puppet version to install:
# 'original': As provided in the box
# 'latest': Installed from PuppetLabs repos
# 'x.y.z-k': Specific version, installed from PuppetLabs repos
puppetversion = '3.5.1-1'

# Nodes list
nodes = [
  { :hostname => 'puppet',    :ip => '10.42.42.10',  :puppetmode => 'apply', ram: '515', cpu: '2' },
  { :hostname => 'lb01',      :ip => '10.42.42.91',  :puppetmode => mode },
  { :hostname => 'web01',     :ip => '10.42.42.101', :puppetmode => mode },
  { :hostname => 'web02',     :ip => '10.42.42.102', :puppetmode => mode },
  { :hostname => 'db01',      :ip => '10.42.42.141', :puppetmode => mode , ram: '512' },
  { :hostname => 'el01',      :ip => '10.42.42.151', :puppetmode => mode },
  { :hostname => 'log',       :ip => '10.42.42.15',  :puppetmode => mode },
  { :hostname => 'mon',       :ip => '10.42.42.16',  :puppetmode => mode },
]

# Boxes available
boxes = {
  :Centos64_64   => { :box => 'centos-64-x64-vbox4210',           :box_url => 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box',           :breed => 'redhat' },
  :Centos59_64   => { :box => 'centos-59-x64-vbox4210',           :box_url => 'http://puppet-vagrant-boxes.puppetlabs.com/centos-59-x64-vbox4210.box',           :breed => 'redhat' },
  :Ubuntu1404_64 => { :box => 'trusty-server-cloudimg-amd64-vagrant-disk1.box', :box_url => 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box', :breed => 'debian' },
  :Ubuntu1204_64 => { :box => 'ubuntu-server-12042-x64-vbox4210', :box_url => 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box', :breed => 'debian' },
  :Ubuntu1004_64 => { :box => 'ubuntu-server-10044-x64-vbox4210', :box_url => 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-10044-x64-vbox4210.box', :breed => 'debian' },
  :Debian7_64    => { :box => 'debian-70rc1-x64-vbox4210',        :box_url => 'http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210.box',        :breed => 'debian' },
  :Debian6_64    => { :box => 'debian-607-x64-vbox4210',          :box_url => 'http://puppet-vagrant-boxes.puppetlabs.com/debian-607-x64-vbox4210.box',          :breed => 'debian' },
  :Suse11_64     => { :box => 'sles-11sp1-x64-vbox4210',          :box_url => 'http://puppet-vagrant-boxes.puppetlabs.com/sles-11sp1-x64-vbox4210.box',          :breed => 'suse' },
}

# Vagrant configuration
Vagrant.configure("2") do |config|

  # Cache plugin
  config.cache.auto_detect = true

  # Shell provisioner, to setup minimal conditions for Puppet provisioning
  config.vm.provision "shell", path: 'bin/setup-' + boxes[default_os.to_sym][:breed] + '.sh', args: puppetversion

  # Nodes configuration
  nodes.each do |node|

    if node[:hostname] == 'puppet'
#      config.vm.provision "shell", path: 'bin/setup-puppetmaster.sh'
    end

    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = boxes[default_os.to_sym][:box]
      node_config.vm.box_url = boxes[default_os.to_sym][:box_url]
      node_config.vm.host_name = node[:hostname] + '.' + domain
      node_config.vm.network :private_network, ip: node[:ip] if node[:ip]

      if node[:forwards]
        node[:forwards].each do |from,to|
          node_config.vm.forward_port from, to
        end
      end

      memory = node[:ram] ? node[:ram] : default_ram ;
      cpu = node[:cpu] ? node[:cpu] : default_cpu ;
      node_config.vm.provider "virtualbox" do |v|
        v.customize [ 'modifyvm', :id, '--name', node[:hostname], '--memory', memory.to_s ]
        v.customize [ 'modifyvm', :id, '--cpus', cpu.to_s ]
        v.customize [ 'setextradata', :id, 'VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root', '1']
      end
    end
  end

# Puppet provisioner configuration
  config.vm.provision :puppet do |puppet|
    puppet.hiera_config_path = 'hiera-vagrant.yaml'
    puppet.working_directory = '/vagrant'
    puppet.manifests_path = 'manifests' 
    puppet.manifest_file = 'site.pp' 
    puppet.module_path = [ 'modules' , 'site' ]
#    puppet.puppet_server = 'puppet01' + domain if nodes[:puppetmode] == 'agent'

    puppet.options = [
      '--verbose',
      '--report',
      '--show_diff',
      '--pluginsync',
      '--summarize',
#      '--evaltrace',
#      '--debug',
#      '--parser future',
    ]
  end
end

