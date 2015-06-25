# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe 'container::ndenv' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['container']['ndenv']['versions'] = ['0.10.26', '0.10.33']
      node.set['container']['ndenv']['global'] = '0.10.26'
      node.set['container']['ndenv']['packages'] = ['grunt', 'grunt-cli']
    end.converge described_recipe
  end

  it 'does include default recipe' do
    expect(subject).to include_recipe('container')
  end

  it 'should install openjdk' do
    expect(subject).to install_package('openjdk-7-jre-headless')
  end

  it 'does includes ndenv recipes' do
    expect(subject).to include_recipe('ndenv::default')
    expect(subject).to include_recipe('ndenv::install')
  end

  it 'should install npm packages' do
    ['0.10.26', '0.10.33'].each do |node_version|
      ['grunt', 'grunt-cli'].each do |pkg|
        expect(subject).to install_ndenv_npm("#{node_version}-#{pkg}")
          .with(package_name: pkg,
                node_version: node_version)
      end
    end
  end
end
