# -*- coding: utf-8 -*-
#
# Cookbook Name:: container
# Recipe:: pyenv
#
# Copyright 2014, Numergy
#
# All rights reserved - Do Not Redistribute
#

node.default['pyenv']['pythons'] = ['2.7.6', '3.3.3']
node.default['pyenv']['global'] = '2.7.6'

include_recipe 'pyenv::system'

node['pyenv']['pythons'].each do |python_version|
  pyenv_script "install-tox-on-#{python_version}" do
    pyenv_version python_version
    code %(pip install --upgrade tox)
  end

  pyenv_rehash "rehash-#{python_version}"
end
