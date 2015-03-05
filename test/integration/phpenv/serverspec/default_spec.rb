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
require 'serverspec'
set :backend, :exec

['5.3.29', '5.4.35', '5.5.19'].each do |php_version|
  describe file("/opt/phpenv/versions/#{php_version}") do
    it { should be_directory }
  end

  describe file("/opt/phpenv/versions/#{php_version}/bin/pear") do
    it { should be_file }
  end
end

describe file('/opt/phpenv/version') do
  its(:content) { should match(/5.3.29/) }
end
