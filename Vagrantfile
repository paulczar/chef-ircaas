Vagrant.require_plugin "vagrant-berkshelf"
Vagrant.require_plugin "vagrant-chef-zero"
Vagrant.require_plugin "vagrant-omnibus"

Vagrant.configure("2") do |config|
  # Berkshelf plugin configuration
  config.berkshelf.enabled = true

  # Chef-Zero plugin configuration
  config.chef_zero.enabled = true
  config.chef_zero.chef_repo_path = "."

  # Omnibus plugin configuration
  config.omnibus.chef_version = :latest

  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Ubuntu 12.04 Config
  config.vm.define :ubuntu1204 do |ubuntu1204|
    ubuntu1204.vm.hostname = "ubuntu1204.vagrant"
    ubuntu1204.vm.box = "docker-ubuntu-12.04"
    ubuntu1204.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/ubuntu-12.04.3-amd64-vbox.box"
    ubuntu1204.vm.provision :chef_client do |chef|
      chef.json = {}
      #chef.environments_path = 'environments/'
      chef.environment = 'development'
      #chef.log_level = :debug
      chef.run_list = [ "recipe[apt::default]", "recipe[ruby::default]", "recipe[ircaas::application]" ]
    end
  end

end
