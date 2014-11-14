# -*- coding: utf-8 -*-
#
# Cookbook Name:: container
# Recipe:: ndenv
#
# Copyright 2014, Numergy
#
# All rights reserved - Do Not Redistribute
#

node.override['ndenv']['user'] = 'root'
node.override['ndenv']['user_home'] = '/root/'
node.override['ndenv']['group'] = 'root'
node.override['ndenv']['manage_home'] = false
node.override['ndenv']['installs'] = ['0.10.26']
node.override['ndenv']['global'] = '0.10.26'

include_recipe 'container'
include_recipe 'ndenv'
include_recipe 'ndenv::install'

node['ndenv']['installs'].each do |node_version|
  %w(grunt grunt-cli bower).each do |npm_pkg|
    ndenv_npm "#{node_version}-#{npm_pkg}" do
      package_name npm_pkg
      node_version node_version
    end
  end
end
