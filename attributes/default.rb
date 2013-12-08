default['ircaas']['database']['type'] = 'sqlite'

default['ircaas']['user'] = 'ircaas'
default['ircaas']['path'] = '/opt/ircaas'

default['ircaas']['git']['repo'] = 'https://github.com/paulczar/IRCaaS.git'
default['ircaas']['git']['branch'] = 'master'

default['ircaas']['hostname'] = automatic['hostname']

override['apache']['user'] = default['ircaas']['user']
override['apache']['group'] = default['ircaas']['user']