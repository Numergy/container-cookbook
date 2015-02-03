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

describe 'container::ndenv' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['container']['ndenv']['versions'] = ['0.10.26', '0.10.33']
      node.set['container']['ndenv']['global'] = '0.10.26'
      node.set['container']['ndenv']['packages'] = ['grunt', 'grunt-cli']
    end.converge described_recipe
  end

  it 'does include default recipe' do
    expect(subject).to include_recipe('container')
  end

  it 'does includes ndenv recipes' do
    expect(subject).to include_recipe('ndenv::default')
    expect(subject).to include_recipe('ndenv::install')
  end

  it 'should install npm packages' do
    ['0.10.26', '0.10.33'].each do |node_version|
      ['grunt', 'grunt-cli'].each do |pkg|
        expect(subject).to install_ndenv_npm("#{node_version}-#{pkg}")
          .with(package_name: pkg,
                node_version: node_version)
      end
    end
  end
end
