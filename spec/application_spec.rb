require_relative 'spec_helper'

describe 'ircaas::application' do
  describe 'ubuntu' do
    before do
      stubs
      @chef_run = ::ChefSpec::Runner.new ::UBUNTU_OPTS do |node|
        node.set['ircaas'] = {
          user: 'user',
          path: '/dir',
          git: { repo: 'ssh://git.path', branch: 'master' }
        }
        node.set['network']['interfaces']['lxbr0'] = MOCK_NODE_NETWORK_DATA['network']['interfaces']['lxbr0']
      end
      @chef_run.converge 'ircaas::application'
    end

    %w{ ruby::default git::default docker::default }.each do |recipe|
      it "includes #{recipe} recipe" do
        expect(@chef_run).to include_recipe(recipe)
      end
    end

    %w{ sqlite3 libsqlite3-dev libxslt-dev libxml2-dev libpq-dev }.each do |pkg|
      it "installs package #{pkg}" do
        expect(@chef_run).to install_package (pkg)
      end
    end

    it 'creates ircaas user' do
      expect(@chef_run).to create_user('user')
    end

    it 'adds user to the docker group' do
      expect(@chef_run).to modify_group('docker').with(members: ['user'])
    end

    it 'pulls paulczar/znc docker image' do
      resource = @chef_run.find_resource(
        'docker_image',
        'paulczar/znc'
      ).to_hash
      expect(resource).to include(
        :action => [:pull]
      )
    end

    it 'creates dir /dir' do
      expect(@chef_run).to create_directory('/dir').with(owner: 'user', group: 'user', mode: 00755)
    end

    it 'adds shared directories' do
      %w{config log pids cached-copy bundle system}.each do |dir|
        expect(@chef_run).to create_directory("/dir/shared/#{dir}").with(owner: 'user', group: 'user', mode: 00755)
      end
    end

    it 'installs bundler gem with an explicit action' do
      expect(@chef_run).to install_gem_package('bundler')
    end    

    it 'installs ircaas application' do
      resource = @chef_run.find_resource(
        'application',
        'ircaas'
      ).to_hash
      expect(resource).to include(
        :action => [:deploy]
      )
    end

    it 'creates dir /dir/current/tmp' do
      expect(@chef_run).to create_directory('/dir/current/tmp').with(owner: 'user', group: 'user', mode: 00755)
    end

    it 'creates file /dir/current/tmp/restart.txt' do
      expect(@chef_run).to create_file('/dir/current/tmp/restart.txt').with(owner: 'user', group: 'user', mode: 00644)
    end


  end
end
