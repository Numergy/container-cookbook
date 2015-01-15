# -*- coding: utf-8 -*-
#
# Cookbook Name:: container
# Recipe:: jenv
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

node.default['jenv']['user'] = 'root'
node.default['jenv']['group'] = 'root'
node.default['jenv']['user_home'] = '/root/'

include_recipe 'container'
include_recipe 'jenv'

node['container']['jenv']['versions'].each do |java_version|
  jenv_install java_version
end

jenv_global node['container']['jenv']['global']

node['container']['jenv']['plugins']['enable'].each do |java_plugin|
  jenv_plugin java_plugin
end

node['container']['jenv']['plugins']['disable'].each do |java_plugin|
  jenv_plugin java_plugin do
    action :disable
  end
end

include_recipe 'maven'
