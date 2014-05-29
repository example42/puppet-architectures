# Puppet Architectures

Sample Puppet architectures layouts for the book [Extending Puppet](http://www.packtpub.com/extending-puppet/book)  which can be tested via Vagrant.

## Installation

This is a multi vm Vagrant environment where you can test different Puppet setups.
The usual vagrant commands apply.
Use the ./parc script to select and use an alternative architectures.

Needed software:
- [Puppet](http://www.puppetlabs.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](http://www.vagrantup.com/)
- [Librarian Puppet](http://librarian-puppet.com/)
- [Git](http://git-scm.com/)
- Plugin: [vagrant-cachier](http://fgrehm.viewdocs.io/vagrant-cachier)
  This is Optional. Can be installed with: vagrant plugin install vagrant-cachier
- Plugin: [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) (Optional)
  This is Optional. Can be installed with: vagrant plugin install vagrant-vbguest

Once you have these tools installed you can setup the envrionment with the architecture layout you prefer.

To list the available architectures layout samples:

    sh parc list

To install one architecture layout (here: 'nodeless'):

    sh parc install nodeless

To list the available Vagrant VMs:

    vagrant list

To start one VM (here: web01) Note that the first time you do it it may take some time to download the Vagrant box from the net :

    vagrant up web01

To start all the VMs

    vagrant up

For help on Vagrant usage:

    vagrant help


## Customizing the Vagrantfile

The Vagrantfile provided in this repository can be customized in various ways.
Open it and check is contents. At its beginning you can set:

The default OS to use on your VMs. You can choose any name form the 'boxes' list you see later in the Vagrantfile (Note: Tests were done mostly with Centos6_64 and Ubuntu1204_64:

    default_os = 'Centos64_64'

The domain to use for all your nodes:

    domain = 'example42.com'

How much RAM to allocate for each VM (can be overriden per node)

    default_ram = '256'

How many Vrtual CPUs to allocate for each VM (can be overriden per node)

    default_cpu = '1'

You can also change the VM available under Vagrant, editing the 'nodes' hash, and the baseboxes to use, editing the 'boxes' hash.



## Issues

If you have problems with shared folders be sure to have on the used Vagrant boxes a version of VirtualBox additions compatible with the one of your Host.
Install the vagrant vbguest plugin to automatically update the VBox additions when starting a box.

