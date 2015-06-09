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

describe 'container::rbenv' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['container']['rbenv']['versions'] = ['1.9.3-p547',
                                                    '2.0.0-p598',
                                                    '2.1.0-rc1']
      node.set['container']['rbenv']['global'] = '2.0.0-p598'
      node.set['container']['rbenv']['packages'] = %w(bundler gemirro)
    end.converge described_recipe
  end

  it 'does include default recipe' do
    expect(subject).to include_recipe('container')
  end

  it 'does includes rbenv recipes' do
    expect(subject).to include_recipe('rbenv')
    expect(subject).to include_recipe('rbenv::ruby_build')
  end

  it 'should install ruby binaries' do
    expect(subject)
      .to create_remote_file('/opt/rbenv/versions/ruby-2.1.0.tar.bz2')
      .with(source: 'http://binaries.intercityup.com/ruby/ubuntu/14.04/x86_64/ruby-2.1.0.tar.bz2')
    expect(subject).to run_execute('install-ruby-2.1.0-binaries')
      .with(command: "tar jxf ruby-2.1.0.tar.bz2\nrm ruby-2.1.0.tar.bz2\n",
            user: 'root',
            group: 'root',
            cwd: '/opt/rbenv/versions')
  end

  it 'install rbenv' do
    ['1.9.3-p547', '2.0.0-p598', '2.1.0-rc1'].each do |ruby_version|
      expect(subject).to install_rbenv_ruby(ruby_version)
        .with(global: ruby_version == '2.0.0-p598')
      %w(gemirro bundler).each do |pkg|
        expect(subject)
          .to install_rbenv_gem("install-#{pkg}-on-#{ruby_version}")
          .with(package_name: pkg,
                ruby_version: ruby_version)
      end
    end
  end
end
