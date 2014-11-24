# -*- coding: utf-8 -*-
#
# Cookbook Name:: container
# Recipe:: rbenv
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

node.default['rbenv']['user'] = 'root'
node.default['rbenv']['group'] = 'root'
node.default['rbenv']['user_home'] = '/root/'

include_recipe 'container'
include_recipe 'rbenv'
include_recipe 'rbenv::ruby_build'

gem_package 'bundler' do
  action :install
end

node['container']['rbenv']['versions'].each do |rb_version|
  rbenv_ruby rb_version do
    global rb_version == node['container']['rbenv']['global']
  end

  node['container']['rbenv']['packages'].each do |rb_package|
    rbenv_gem "install-#{rb_package}-on-#{rb_version}" do
      package_name rb_package
      ruby_version rb_version
    end
  end
end
