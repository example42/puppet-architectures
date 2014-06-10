# if puppet is not in your RUBYLIB:
# $LOAD_PATH.unshift('/opt/puppet/lib')
$0 = "master"
# ARGV << "--debug" # Uncomment to debug
ARGV << "--rack"
ARGV << "--confdir" << "/etc/puppet"
ARGV << "--vardir" << "/var/lib/puppet"
require 'puppet/util/command_line'
run Puppet::Util::CommandLine.new.execute

