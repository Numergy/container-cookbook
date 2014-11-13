# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'container::pyenv' do
  subject { ChefSpec::Runner.new.converge(described_recipe) }

  it 'does includes recipes' do
    expect(subject).to include_recipe('pyenv::system')
  end

  it 'install pip packages' do
    %w(2.7.6 3.3.3).each do |python_version|
      expect(subject).to run_pyenv_rehash("rehash-#{python_version}")
      expect(subject).to run_pyenv_script("install-tox-on-#{python_version}")
        .with(pyenv_version: python_version)
    end
  end
end
