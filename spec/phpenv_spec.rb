# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe 'container::phpenv' do
  include_context '#phpstubs'

  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['container']['phpenv']['versions'] = ['5.3.29', '5.4.2']
      node.set['container']['phpenv']['global'] = '5.3.29'
    end.converge described_recipe
  end

  it 'does include default recipe' do
    expect(subject).to include_recipe('container')
  end

  it 'does create symlink with execute command' do
    expect(subject).to run_execute('link-libraries')
      .with(command: 'ln -sf /usr/lib/x86_64-linux-gnu/ /usr/lib64')
  end

  it 'does includes phpenv recipe' do
    expect(subject).to include_recipe('phpenv')
  end

  it 'should install php versions' do
    %w(5.3.29 5.4.2).each do |php_version|
      expect(subject).to run_phpenv_build(php_version)
      expect(subject).to create_template("ci-#{php_version}.ini")
        .with(source: 'php/ci.ini.erb',
              path: "/opt/phpenv/versions/#{php_version}/etc/conf.d/ci.ini")
    end

    expect(subject).to create_phpenv_global('5.3.29')
  end
end
