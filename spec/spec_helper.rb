# -*- coding: utf-8 -*-
require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! do
  add_filter('container')
end

require 'chef/application'
RSpec.configure do |config|
  config.log_level = :error
  config.platform = 'ubuntu'
  config.version = '14.04'
end

shared_context '#phpstubs' do
  before do
    stub_command("[ -z \"$(./pyrus list-packages | egrep '^my_package ')\" ]")
      .and_return(true)
    stub_command("[ -z \"$(./pear list -a | egrep '^phpcs ')\" ]")
      .and_return(true)
  end
end
