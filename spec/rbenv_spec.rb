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
  subject { ChefSpec::Runner.new.converge(described_recipe) }

  it 'does include default recipe' do
    expect(subject).to include_recipe('container')
  end

  it 'does includes rbenv recipes' do
    expect(subject).to include_recipe('rbenv')
    expect(subject).to include_recipe('rbenv::ruby_build')
  end

  it 'install rbenv' do
    expect(subject).to install_gem_package('bundler')

    %w(1.9.3-p547 2.0.0-p451).each do |ruby_version|
      expect(subject).to install_rbenv_ruby(ruby_version)
      expect(subject).to install_rbenv_gem("install-bundler-on-#{ruby_version}")
        .with(package_name: 'bundler',
              ruby_version: ruby_version)
    end
  end
end
