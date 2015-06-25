# -*- coding: utf-8 -*-
require 'serverspec'
set :backend, :exec

['5.3.29', '5.4.35', '5.5.19'].each do |php_version|
  describe file("/opt/phpenv/versions/#{php_version}") do
    it { should be_directory }
  end

  describe file("/opt/phpenv/versions/#{php_version}/bin/pear") do
    it { should be_file }
  end
end

describe file('/opt/phpenv/version') do
  its(:content) { should match(/5.3.29/) }
end
