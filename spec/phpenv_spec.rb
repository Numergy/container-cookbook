# -*- coding: utf-8 -*-
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require_relative 'spec_helper'

describe 'container::phpenv' do
  include_context '#phpstubs'

  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.set['container']['phpenv']['versions'] = ['5.3.29', '5.4.2']
      node.set['container']['phpenv']['global'] = '5.3.29'
      node.set['container']['phpenv']['pyrus_extensions'] = ['pecl/my_package']
      node.set['container']['phpenv']['pear_extensions'] = ['pecl/phpcs']
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
      expect(subject).to run_execute("touch-directory-#{php_version}")
        .with(command: "touch /opt/phpenv/versions/#{php_version}/bin/")
      expect(subject)
        .to run_phpenv_script("install-pyrus-pecl/my_package-#{php_version}")
        .with(phpenv_version: php_version,
              code: 'pyrus install pecl/my_package')
      expect(subject).to run_phpenv_script("pecl-config-#{php_version}")
        .with(phpenv_version: php_version,
              code: 'pear config-set php_ini /opt/phpenv/versions' \
              "/#{php_version}/etc/php.ini")
      expect(subject)
        .to run_phpenv_script("install-pear-pecl/phpcs-#{php_version}")
        .with(phpenv_version: php_version,
              code: 'pear install pecl/phpcs')
    end

    expect(subject).to create_phpenv_global('5.3.29')
  end
end
