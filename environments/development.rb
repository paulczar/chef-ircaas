name 'development'
description 'development environment'

override_attributes(
  'languages' => {
    'ruby' => {
      'default_version' => '1.9.1'
    }
  },
  'passenger' => {
    'version'           => '4.0.14',
    'root_path'         => "/var/lib/gems/1.9.1/gems/passenger-4.0.14",
    'ruby_bin'          => '/usr/bin/ruby1.9.1'
  },
  'ircaas' => {
    'hostname'         => 'localhost'
  }
)

