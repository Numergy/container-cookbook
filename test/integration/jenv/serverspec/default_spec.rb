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

describe user('jenv') do
  it { should_not exist }
end

describe group('jenv') do
  it { should_not exist }
end

describe file('/opt/jenv/versions/1.6') do
  it { should be_directory }
end

describe file('/opt/jenv/versions/1.7') do
  it { should be_directory }
end

describe file('/opt/jenv/version') do
  its(:content) { should match(/1\.7/) }
end
