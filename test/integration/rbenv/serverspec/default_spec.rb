# -*- coding: utf-8 -*-
require 'serverspec'
set :backend, :exec

bins = ['/opt/rbenv/shims/ruby',
        '/opt/rbenv/shims/gem',
        '/opt/rbenv/shims/bundler',
        '/opt/rbenv/versions/1.9.3-p547/bin/bundler',
        '/opt/rbenv/versions/2.0.0-p598/bin/bundler',
        '/opt/rbenv/versions/2.1.0/bin/bundler',
        '/opt/rbenv/versions/2.1.5/bin/bundler']

bins.each do |command|
  describe file(command) do
    it { should be_file }
    it { should be_executable }
  end
end

describe file('/opt/rbenv/version') do
  its(:content) { should match(/1.9.3-p547/) }
end
