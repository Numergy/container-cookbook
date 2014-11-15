# -*- coding: utf-8 -*-
#
# Cookbook Name:: container
# Recipe:: ndenv
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
