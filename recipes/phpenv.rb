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

node.default['phpenv']['user'] = 'root'
node.default['phpenv']['group'] = 'root'
node.default['phpenv']['user_home'] = '/root/'

include_recipe 'container'

execute 'link-libraries' do
  command 'ln -sf /usr/lib/x86_64-linux-gnu/ /usr/lib64'
end

include_recipe 'phpenv'

node['container']['phpenv']['versions'].each do |php_version|
  phpenv_build php_version
  cookbook_file "ci-#{php_version}.ini" do
    source 'php/ci.ini'
    path("#{node['phpenv']['root_path']}/" \
         "versions/#{php_version}/etc/conf.d/ci.ini")
    action :create
  end

  # Move directory to fix bug with docker aufs
  execute "move-directory-#{php_version}" do
    command("mv #{node['phpenv']['root_path']}/versions/#{php_version}/bin/" \
            " /opt/phpenv/versions/#{php_version}/.old-bin;" \
            "mv #{node['phpenv']['root_path']}/versions/#{php_version}/" \
            ".old-bin/ /opt/phpenv/versions/#{php_version}/bin")
  end

  node['container']['phpenv']['pyrus_extensions'].each do |extension|
    phpenv_script "install-pyrus-#{extension}-#{php_version}" do
      phpenv_version php_version
      code "pyrus install #{extension}"
    end
  end

  phpenv_script "pecl-config-#{php_version}" do
    phpenv_version php_version
    code("pear config-set php_ini #{node['phpenv']['root_path']}/" \
         "versions/#{php_version}/etc/php.ini")
  end

  node['container']['phpenv']['pear_extensions'].each do |extension|
    phpenv_script "install-pear-#{extension}-#{php_version}" do
      phpenv_version php_version
      code "pear install -f #{extension}"
    end
  end
end

phpenv_global node['container']['phpenv']['global']
