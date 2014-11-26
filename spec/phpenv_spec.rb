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

describe 'container::phpenv' do
  let(:subject) do
    ChefSpec::Runner.new do |node|
      node.set['container']['phpenv']['versions'] = ['5.3.29', '5.4.2']
      node.set['container']['phpenv']['global'] = '5.3.29'
    end.converge described_recipe
  end

  it 'does include default recipe' do
    expect(subject).to include_recipe('container')
  end

  it 'does install libreadline-dev package' do
    expect(subject).to install_package('libreadline-dev')
  end

  it 'does create symlink with execute command' do
    expect(subject).to run_execute('link-libraries')
      .with(command: 'ln -s /usr/lib/x86_64-linux-gnu/ /usr/lib64')
  end

  it 'does includes phpenv recipe' do
    expect(subject).to include_recipe('phpenv')
  end

  it 'should install php' do
    expect(subject).to run_phpenv_build('5.3.29')
    expect(subject).to run_phpenv_build('5.4.2')
    expect(subject).to create_phpenv_global('5.3.29')
  end
end
