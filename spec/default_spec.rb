# -*- coding: utf-8 -*-
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
