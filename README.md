# Puppet Architectures

Sample Puppet architectures layouts that can be tested in a Vagrant environment

This is the downloadable material for the book [Extending Puppet](http://www.packtpub.com/extending-puppet/book).

Consider it as a live reference that can fail at times.
This is an ongoing work in progress, not all combinations of architectures, machine types and Linux distributions have been tested, and new problems might arise with future Puppet and Vagrant versions. 

## Installation

This is basically a multi VM Vagrant environment where you can test different Puppet setups.

The usual vagrant commands apply. Ttpe ```vagrant help``` for Vagrant commands.

Different architectures examples can be installed with the ```parc``` script.

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

To start all the VMs (Warning: This might consume a lot of resources for your system) :

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

How much RAM to allocate for each VM by default (can be overridden per node):

    default_ram = '256'

How many Vrtual CPUs to allocate for each VM (can be overridden per node)

    default_cpu = '1'

You can also change the VM available under Vagrant, editing the 'nodes' hash, and the baseboxes to use, editing the 'boxes' hash.



## Possible issues

- If you have problems with shared folders be sure to have on the used Vagrant boxes a version of VirtualBox additions compatible with the one of your Host. Install the vagrant vbguest plugin to automatically update the VBox additions when starting a box.
- Problems during Puppet provisioning are expected. They might be due to:
  - The installed Puppet version might not be compatible with the used modules
  - The specific combination of architectures, VM type and used OS may not work out of the box
  - Many more or less arcane or untested conditions

Please open bug reports on [GitHub](https://github.com/example42/puppet-architectures/issues)



