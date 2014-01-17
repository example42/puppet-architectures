= Puppet Architectures

Sample Puppet architectures layouts for the book "Puppet Architectures"  which can be tested via Vagrant.

== Usage

This is a multi vm Vagrant environment where you can test different Puppet setups.
The usual vagrant commands apply.
Use the ./parc script to select and use an alternative architectures.

Required software:
- VirtualBox
- Vagrant
- Vagrant plugin: cachier
- Vagrant plugin: vbguest (Optional)

== Issues

If you have problems with shared folders be sure to have on the used Vagrant boxes a version of VirtualBox additions compatible
with the one of your Host.
Install the vagrant vbguest plugin to automatically update the VBox additions when starting a box.

