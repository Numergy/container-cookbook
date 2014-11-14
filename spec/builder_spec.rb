# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'container::builder' do
  subject { ChefSpec::Runner.new.converge(described_recipe) }

  it 'does include docker recipe' do
    expect(subject).to include_recipe('docker')
  end

  it 'does install gem packages' do
    expect(subject).to install_gem_package('knife-container')
  end
end
