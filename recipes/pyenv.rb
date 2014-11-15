# -*- coding: utf-8 -*-
#
# Cookbook Name:: container
# Recipe:: pyenv
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

node.default['pyenv']['pythons'] = ['2.7.6', '3.3.3']
node.default['pyenv']['global'] = '2.7.6'

include_recipe 'container'
include_recipe 'pyenv::system'

node['pyenv']['pythons'].each do |python_version|
  pyenv_script "install-tox-on-#{python_version}" do
    pyenv_version python_version
    code %(pip install --upgrade tox)
  end

  pyenv_rehash "rehash-#{python_version}"
end
