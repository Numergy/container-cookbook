# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! do
  add_filter(/container/)
end

require 'chef/application'
RSpec.configure do |config|
  config.log_level = :error
  config.platform = 'ubuntu'
  config.version = '14.04'
end
