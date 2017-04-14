#
# Credit to Graham Gilbert for this fact.
# current_user.rb
#
Facter.add('current_user') do
  confine kernel: 'Darwin'
  setcode do
    Facter::Util::Resolution.exec('/bin/ls -l /dev/console').split(' ')[2]
  end
end
