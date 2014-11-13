# -*- coding: utf-8 -*-
#
# Cookbook Name:: container
# Recipe:: rbenv
#
# Copyright 2014, Numergy
#
# All rights reserved - Do Not Redistribute
#

node.default['rbenv']['user'] = 'root'
node.default['rbenv']['group'] = 'root'
node.default['rbenv']['user_home'] = '/root/'
node.default['rbenv']['root_path'] = '/root/.rbenv'

include_recipe 'rbenv'
include_recipe 'rbenv::ruby_build'

global_version = '1.9.3-p547'

gem_package 'bundler' do
  action :install
end

%w(1.9.3-p547 2.0.0-p451).each do |rb_version|
  rbenv_ruby rb_version do
    global rb_version == global_version
  end

  rbenv_gem "install-bundler-on-#{rb_version}" do
    package_name 'bundler'
    ruby_version rb_version
  end
end
