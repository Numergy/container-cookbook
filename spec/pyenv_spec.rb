# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe 'container::pyenv' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['container']['pyenv']['versions'] = ['2.7.6', '3.3.3', '3.4-dev']
      node.set['container']['pyenv']['global'] = '3.3.3'
      node.set['container']['pyenv']['packages'] = ['tox']
    end.converge described_recipe
  end

  it 'does include default recipe' do
    expect(subject).to include_recipe('container')
  end

  it 'does includes pyenv recipe' do
    expect(subject).to include_recipe('pyenv::system')
  end

  it 'install pip packages' do
    ['2.7.6', '3.3.3', '3.4-dev'].each do |python_version|
      expect(subject).to run_pyenv_rehash("rehash-#{python_version}")
      expect(subject).to run_pyenv_script("install-tox-on-#{python_version}")
        .with(pyenv_version: python_version)
    end
  end
end
