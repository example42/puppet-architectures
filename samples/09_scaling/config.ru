# if puppet is not in your RUBYLIB:
# $LOAD_PATH.unshift('/opt/puppet/lib')
$0 = "master"
# ARGV << "--debug" # Uncomment to debug
ARGV << "--rack"
ARGV << "--confdir" << "/etc/puppet"
ARGV << "--vardir" << "/var/lib/puppet"
require 'puppet/util/command_line'
<% if @rubyversion[0..2].to_f >= 1.9 -%>
# https://projects.puppetlabs.com/issues/20897
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
<% end -%>
run Puppet::Util::CommandLine.new.execute

