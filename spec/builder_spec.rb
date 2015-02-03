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

describe 'container::builder' do
  subject { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'does include docker recipe' do
    expect(subject).to include_recipe('docker')
  end

  it 'does install gem packages' do
    expect(subject).to install_gem_package('knife-container')
  end
end
