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

describe 'container::pyenv' do
  let(:subject) do
    ChefSpec::Runner.new do |node|
      node.set['container']['pyenv']['versions'] = ['2.7.6', '3.3.3', '3.4-dev']
      node.set['container']['pyenv']['global'] = '3.3.3'
      node.set['container']['pyenv']['packages'] = ['tox']
    end.converge described_recipe
  end

  it 'does include default recipe' do
    expect(subject).to include_recipe('container')
  end

  it 'does includes pyenv recipe' do
    expect(subject).to include_recipe('pyenv::system')
  end

  it 'install pip packages' do
    ['2.7.6', '3.3.3', '3.4-dev'].each do |python_version|
      expect(subject).to run_pyenv_rehash("rehash-#{python_version}")
      expect(subject).to run_pyenv_script("install-tox-on-#{python_version}")
        .with(pyenv_version: python_version)
    end
  end
end
