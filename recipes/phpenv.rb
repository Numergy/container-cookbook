# -*- coding: utf-8 -*-
#
# Cookbook Name:: container
# Recipe:: phpenv
#
# Copyright 2014, Numergy
#
# All rights reserved - Do Not Redistribute
#

node.default['phpenv']['user'] = 'root'
node.default['phpenv']['group'] = 'root'
node.default['phpenv']['user_home'] = '/root/'
node.default['phpenv']['root_path'] = '/root/.phpenv'

package 'libreadline-dev'

include_recipe 'phpenv'

phpenv_build '5.3.29'
phpenv_global '5.3.29'
