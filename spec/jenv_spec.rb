# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe 'container::jenv' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['container']['jenv']['versions'] = ['42']
      node.set['container']['jenv']['plugins']['enable'] = ['groovy']
      node.set['container']['jenv']['plugins']['disable'] = ['maven']
      node.set['container']['jenv']['global'] = '42'
    end.converge described_recipe
  end

  it 'does include default recipe' do
    expect(subject).to include_recipe('container')
  end

  it 'does includes jenv recipe' do
    expect(subject).to include_recipe('jenv')
  end

  it 'should install java' do
    expect(subject).to run_jenv_install('42')
    expect(subject).to create_jenv_global('42')
    expect(subject).to enable_jenv_plugin('groovy')
    expect(subject).to disable_jenv_plugin('maven')
  end
end
