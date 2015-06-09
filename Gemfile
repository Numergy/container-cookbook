# -*- coding: utf-8 -*-

source 'https://rubygems.org'

gem 'chef', '~> 12'
gem 'chef-provisioning'
# Waiting for release on rubygems
gem 'chef-provisioning-docker', github: 'chef/chef-provisioning-docker'
gem 'berkshelf'

group :integration do
  gem 'rubocop'
  gem 'rake'
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-openstack'
  gem 'serverspec'
  gem 'chefspec'
  gem 'foodcritic'
end
