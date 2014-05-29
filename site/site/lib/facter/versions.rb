if Facter.osfamily == 'RedHat'
  IO.popen('yum list installed').readlines.collect do |line|
      array = line.split
      Facter.add("#{array[0]}_version") do
          setcode do
              "#{array[1]}"
          end
      end
  end
end
if Facter.osfamily == 'Debian'
  IO.popen('dpkg -l').readlines.collect do |line|
      array = line.split
      Facter.add("#{array[1]}_version") do
          setcode do
              "#{array[2]}"
          end
      end
  end
end
