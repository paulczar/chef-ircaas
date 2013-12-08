#
# Cookbook Name:: ircaas
# Recipe:: application
#
# Copyright 2013, Paul Czarkowski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform']
when 'ubuntu'
  include_recipe 'apt'
end

%w{ git::default ruby::default docker::default }.each do |recipe| 
  include_recipe recipe
end

%w{ sqlite3 libsqlite3-dev libxslt-dev libxml2-dev libpq-dev }.each do |pkg|
  package pkg
end

user node['ircaas']['user'] do
  username  node['ircaas']['user']
  comment   'ircaas User'
  shell     '/bin/bash'
  home      '/home/ircaas'
  action    [:create]
end

group 'docker' do
  members     node['ircaas']['user']
  append      true
  action      [:modify]
  notifies    :restart, "service[docker]", :delayed
end

docker_image 'paulczar/znc' do
  action      [:pull]
end

directory node['ircaas']['path'] do
  owner       node['ircaas']['user']
  group       node['ircaas']['user']
  recursive   true
  mode        00755
  action      [:create]
end

%w{config log pids cached-copy bundle system}.each do |dir|
  directory     "#{node['ircaas']['path']}/shared/#{dir}" do
    owner         node['ircaas']['user']
    group         node['ircaas']['user']
    mode          00755
    recursive     true
    action        [:create]
  end
end

gem_package 'bundler' do
  action    [:install]
end


application 'ircaas' do
  action              [:deploy]
  path                node['ircaas']['path']
  owner               node['ircaas']['user']
  group               node['ircaas']['user']
  repository          node['ircaas']['git']['repo']
  revision            node['ircaas']['git']['branch']
  migrate             true
  environment_name    'development'
  environment         'RAILS_ENV' => 'development'
  rails do
    bundler           true
    database do
      adapter   'sqlite3'
      database  'db/development.sqlite3'
    end
  end
  passenger_apache2

end

directory "#{node['ircaas']['path']}/current/tmp" do
  owner     node['ircaas']['user']
  group     node['ircaas']['user']
  mode      00755
  recursive true
  action [:create]
end

file "#{node['ircaas']['path']}/current/tmp/restart.txt" do
  owner     node['ircaas']['user']
  group     node['ircaas']['user']
  mode      00644
  action [:create]
end