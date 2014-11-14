# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'container::ndenv' do
  subject { ChefSpec::Runner.new.converge(described_recipe) }

  it 'does include default recipe' do
    expect(subject).to include_recipe('container')
  end

  it 'does includes ndenv recipes' do
    expect(subject).to include_recipe('ndenv::default')
    expect(subject).to include_recipe('ndenv::install')
  end

  it 'should install npm packages' do
    %w(0.10.26).each do |node_version|
      %w(grunt grunt-cli bower).each do |pkg|
        expect(subject).to install_ndenv_npm("#{node_version}-#{pkg}")
          .with(package_name: pkg,
                node_version: node_version)
      end
    end
  end
end
