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

node.default['ndenv']['user'] = 'root'
node.default['ndenv']['user_home'] = '/root/'
node.default['ndenv']['group'] = 'root'
node.default['ndenv']['manage_home'] = false
node.default['ndenv']['installs'] = node['container']['ndenv']['versions']
node.default['ndenv']['global'] = node['container']['ndenv']['global']

include_recipe 'container'
include_recipe 'chrome'
include_recipe 'xvfb'
include_recipe 'ndenv'
include_recipe 'ndenv::install'
package 'openjdk-7-jre-headless' # Selenium requirements

node['ndenv']['installs'].each do |node_version|
  node['container']['ndenv']['packages'].each do |npm_pkg|
    ndenv_npm "#{node_version}-#{npm_pkg}" do
      package_name npm_pkg
      node_version node_version
    end
  end
end
