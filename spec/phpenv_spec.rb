# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'container::phpenv' do
  subject { ChefSpec::Runner.new.converge(described_recipe) }

  it 'does install libreadline-dev package' do
    expect(subject).to install_package('libreadline-dev')
  end

  it 'does includes recipes' do
    expect(subject).to include_recipe('phpenv')
  end

  it 'should install php' do
    expect(subject).to run_phpenv_build('5.3.29')
    expect(subject).to create_phpenv_global('5.3.29')
  end
end
