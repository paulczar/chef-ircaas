name             'ircaas'
maintainer       'Paul Czarkowski'
maintainer_email 'username.taken@gmail.com'
license          'All rights reserved'
description      'Installs/Configures ircaas'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "ircaas::default", "does nothing"
recipe "ircaas::database", "set up database"
recipe "ircaas::application", "set up rails environment, install code"

%w{ ubuntu }.each do |os|
  supports os
end

%w{ git docker ruby apt build-essential application application_ruby }.each do |dep|
  depends dep
end
