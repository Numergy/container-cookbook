# -*- coding: utf-8 -*-
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
