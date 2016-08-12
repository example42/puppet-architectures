# Deprecation notice

This repo is no longer maintained.

Check [example42 control-repo](https://github.com/example42/control-repo) for updated works.


# Puppet Architectures

This repository contains sample Puppet architecture layouts that can be tested in a Vagrant environment.

Consider it as a live reference, mostly oriented to show different usage patterns on how code and data can be managed in Puppet architectures.

This is an ongoing work in progress, not all combinations of architectures, machine types and Linux distributions have been tested, and new problems might arise with future Puppet and Vagrant versions. 


## Installation

This is basically a multi VM Vagrant environment where you can test different Puppet setups.

The usual vagrant commands apply. Type ```vagrant help``` for Vagrant commands.

Different architectures examples can be installed with the ```parc``` script.

Needed software:
- [Puppet](http://www.puppetlabs.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](http://www.vagrantup.com/)
- [Librarian Puppet](http://librarian-puppet.com/)
- [Git](http://git-scm.com/)
- Plugin: [vagrant-cachier](http://fgrehm.viewdocs.io/vagrant-cachier)
  This is Required. Can be installed with: vagrant plugin install vagrant-cachier
- Plugin: [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) (Optional)
  This is Optional. Can be installed with: vagrant plugin install vagrant-vbguest

Once you have these tools installed you can setup the environment with the architecture layout you prefer.

To list the available architectures layout samples:

    ./parc list

To install one architecture layout (here: 'nodeless'):

    ./parc install nodeless

To list the available Vagrant VMs:

    vagrant list

To start one VM (here: web01) Note that the first time you do it it may take some time to download the Vagrant box from the net :

    vagrant up web01

To start all the VMs (Warning: This might consume a lot of resources for your system) :

    vagrant up

For help on Vagrant usage:

    vagrant help


## Understanding Vagrant and the directory layout

The most important contents of this repository are:

    Puppetfile    # The configuration file for librarian-puppet and r10k.
                  # It contains the list of modules to install in the modules/ dir

    Vagrantfile   # The Vagrant configuration file. Find below info on how to customize it.

    architectures # A directory that contains different sample Puppet architectures

    bin          # Directory with scripts used by Vagrant during provisioning and other tools

    keys         # Directory that contains the hiera-eyaml keys to encrypt data.

    parc         # Script that installs a new architecture, changing links in the main directory.
                 # It creates links to files in the architectures/$linked_architecture/ directory

    manifests    # Directory that contains the manifests used by Vagrant
                 # Link to -> architectures/$linked_architecture/manifests

    modules      # Directory that contains the public shared modules.
                 # As installed by librarian-puppet or r10k

    site         # Directory that contains custom, site modules.
                 # Link to  -> architectures/$linked_architecture/site

    hieradata    # The directory that contains Hiera's data, organized as defined in hiera.yaml 
                 # Link to -> architectures/$linked_architecture/hieradata

    hiera-vagrant.yaml # The Hiera file used by Vagrant during Puppet provisioning in apply mode.
                       # Link to -> architectures/$linked_architecture/hiera-vagrant.yaml

    hiera.yaml         # The Hiera file used on the Master, when provisioning in agent mode.
                       # Link to -> architectures/$linked_architecture/hiera.yaml

    r10k.yaml    # Sample configuration file for r10k

    samples      # Directory containing various sample files. Related to specific book chapters


## Customizing the Vagrantfile

The Vagrantfile provided in this repository can be customized in various ways.

Open it and check is contents. At its beginning you can set:

The default OS to use on your VMs. You can choose any name form the 'boxes' list you see later in the Vagrantfile (Note: Tests were done mostly with Centos6_64 and Ubuntu1204_64:

    default_os = 'Centos64_64'

The domain to use for all your nodes:

    domain = 'example42.com'

How much RAM to allocate for each VM by default (can be overridden per node):

    default_ram = '256'

How many Vrtual CPUs to allocate for each VM (can be overridden per node)

    default_cpu = '1'

You can also change the VM available under Vagrant, editing the 'nodes' hash, for each node you can set RAM, CPU and puppet provisioning mode (note that ```puppetmode => agent``` requires the puppet node to be configured and running correctly as Puppet Master)

    { :hostname => 'my_node', :ip => '10.42.42.10', :puppetmode => 'apply', ram: '515', cpu: '2' },
 
You can update or modify the Vagrant boxes to use, editing the ```boxes``` hash. You can set the base url, the local name, and the breed, which is used to provide different setup scripts for different kind of distributions. Check the line:

    config.vm.provision "shell", path: 'bin/setup-' + boxes[default_os.to_sym][:breed] + '.sh'


    :Centos64_64   => {
      :box => 'centos-64-x64-vbox4210',
      :box_url => 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box',
      :breed => 'redhat'
    },

The puppet version to install on the nodes. Various options are available:
- '```original```': Keep the Puppet version provided in the Vagrant box
- '```latest```': Install latest Puppet version from PuppetLabs repos
- '```x.y.z-k```': Install a specific version from PuppetLabs repos

     puppetversion = '3.5.1-1'

You can change the Puppet options to test future parser or enable debugging options: 

    puppet.options = [
      '--verbose',
      '--report',
      '--show_diff',
      '--pluginsync',
      '--summarize',
    # '--evaltrace',
    # '--debug',
    # '--parser future',
    ]
 

## Possible issues

Many, many things can go wrong in an open and relatively complex setup like this.

Many elements are involved:
- Correct setup of Vagrant and dependent software on your machine
- Availability of the Vagrant base boxes and their compatibility with your Virtual Box version (for this the vbguest plugin can help)
- The installed Puppet version might not be compatible with the used modules (especially if you apply the ```--parser future``` option)
- The sample architectures might not have all the correct settings for all the nodes' roles
- The used OS, depending on the used Vagrant box might not be fully supported in all the combinations
- Many more or less arcane or untested conditions



