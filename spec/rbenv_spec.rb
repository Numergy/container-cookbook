# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'container::rbenv' do
  subject { ChefSpec::Runner.new.converge(described_recipe) }

  it 'does include default recipe' do
    expect(subject).to include_recipe('container')
  end

  it 'does includes rbenv recipes' do
    expect(subject).to include_recipe('rbenv')
    expect(subject).to include_recipe('rbenv::ruby_build')
  end

  it 'install rbenv' do
    expect(subject).to install_gem_package('bundler')

    %w(1.9.3-p547 2.0.0-p451).each do |ruby_version|
      expect(subject).to install_rbenv_ruby(ruby_version)
      expect(subject).to install_rbenv_gem("install-bundler-on-#{ruby_version}")
        .with(package_name: 'bundler',
              ruby_version: ruby_version)
    end
  end
end
