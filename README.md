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
- Plugin: [vagrant-cachier](http://fgrehm.viewdocs.io/vagrant-cachier) (Optional)
- Plugin: [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) (Optional)

## Issues

If you have problems with shared folders be sure to have on the used Vagrant boxes a version of VirtualBox additions compatible with the one of your Host.
Install the vagrant vbguest plugin to automatically update the VBox additions when starting a box.

