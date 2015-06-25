# -*- coding: utf-8 -*-
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

Vagrant::configure('2') do |config|
  config.ssh.forward_agent = true

  config.vm.define 'container-builder' do |builder|
    builder.ssh.username = 'vagrant'

    builder.vm.box = 'ubuntu-14.04'
    builder.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

    builder.vm.network :public_network

    builder.vm.provider 'virtualbox' do |v|
      v.customize ['modifyvm', :id, '--name', 'container-builder']
      v.customize ['modifyvm', :id, '--memory', 2048]
    end

    builder.vm.provision :chef_zero do |chef|
      chef.cookbooks_path = ['cookbooks']
      chef.add_recipe('container')
      chef.add_recipe('docker')
    end

    $script = <<SCRIPT
echo "PATH=$PATH:/opt/chef/embedded/bin" > /etc/profile.d/vagrant.sh
chmod +x /etc/profile.d/vagrant.sh
source /etc/profile.d/vagrant.sh
gem install bundler
pushd /vagrant
bundle install
popd
SCRIPT
    builder.vm.provision :shell, inline: $script
  end
end
