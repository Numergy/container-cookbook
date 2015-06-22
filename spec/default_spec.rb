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

describe 'container::default' do
  subject { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'does include apt recipe' do
    expect(subject).to include_recipe('apt')
  end

  it 'does include build-essential recipe' do
    expect(subject).to include_recipe('build-essential')
  end

  it 'does include locale recipe' do
    expect(subject).to include_recipe('locale')
  end

  it 'does install packege curl' do
    expect(subject).to install_package('curl')
  end
end
