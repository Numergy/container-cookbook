# -*- coding: utf-8 -*-
#
# Cookbook Name:: container
# Recipe:: ndenv
#
# Copyright 2014, Numergy
#
# All rights reserved - Do Not Redistribute
#

Vagrant::configure('2') do | config |

  config.ssh.forward_agent = true
  config.vm.define 'container-builder' do | builder |
    builder.ssh.username = 'vagrant'

    builder.vm.box = 'ubuntu-14.04'
    builder.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

    builder.vm.network :public_network

    builder.vm.provider 'virtualbox' do |v|
      v.gui = true
      v.customize ['modifyvm', :id, '--name', 'container-builder']
      v.customize ['modifyvm', :id, '--memory', 2048]
    end

    builder.vm.provision :shell, inline: 'wget -O - https://www.opscode.com/chef/install.sh | sudo bash'
    builder.vm.provision :chef_solo do | chef |
      chef.cookbooks_path = ['cookbooks']
      chef.add_recipe('container::builder')
    end
  end
end
