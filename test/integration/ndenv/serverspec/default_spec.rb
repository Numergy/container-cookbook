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

bins = ['/opt/ndenv/shims/npm',
        '/opt/ndenv/shims/node']

['0.8.28',
 '0.9.12',
 '0.10.33',
 '0.11.14'].each do |version|
  describe file "/opt/ndenv/versions/v#{version}" do
    it { should be_directory }
  end
end

describe file '/opt/ndenv/version' do
  its(:content) { should match(/v0.10.33/) }
end

bins.each do |command|
  describe file(command) do
    it { should be_file }
    it { should be_executable }
  end
end

describe package('google-chrome-stable') do
  it { should be_installed }
end

describe package('xvfb') do
  it { should be_installed }
end
