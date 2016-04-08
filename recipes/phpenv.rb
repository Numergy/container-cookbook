# -*- coding: utf-8 -*-
#
# Cookbook Name:: container
# Recipe:: phpenv
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

include_recipe 'container'

execute 'link-libraries' do
  command 'ln -sf /usr/lib/x86_64-linux-gnu/ /usr/lib64'
end

include_recipe 'phpenv'

node['container']['phpenv']['versions'].each do |php_version|
  phpenv_build php_version do
    timeout 7200
  end

  template "ci-#{php_version}.ini" do
    source 'php/ci.ini.erb'
    path("#{node['phpenv']['root_path']}/" \
         "versions/#{php_version}/etc/conf.d/ci.ini")
    action :create
  end
end

phpenv_global node['container']['phpenv']['global']
