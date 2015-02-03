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
require_relative 'spec_helper'

describe 'container::jenv' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['container']['jenv']['versions'] = ['42']
      node.set['container']['jenv']['plugins']['enable'] = ['groovy']
      node.set['container']['jenv']['plugins']['disable'] = ['maven']
      node.set['container']['jenv']['global'] = '42'
    end.converge described_recipe
  end

  it 'does include default recipe' do
    expect(subject).to include_recipe('container')
  end

  it 'does includes jenv recipe' do
    expect(subject).to include_recipe('jenv')
  end

  it 'should install java' do
    expect(subject).to run_jenv_install('42')
    expect(subject).to create_jenv_global('42')
    expect(subject).to enable_jenv_plugin('groovy')
    expect(subject).to disable_jenv_plugin('maven')
  end
end
