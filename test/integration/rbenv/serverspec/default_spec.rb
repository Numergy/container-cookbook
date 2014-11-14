# -*- coding: utf-8 -*-

require 'serverspec'
set :backend, :exec

capabilities = ['/root/.rbenv/shims/ruby',
                '/root/.rbenv/shims/gem',
                '/root/.rbenv/shims/bundler',
                '/root/.rbenv/versions/1.9.3-p547/bin/bundler',
                '/root/.rbenv/versions/2.0.0-p451/bin/bundler']

capabilities.each do |command|
  describe file(command) do
    it { should be_file }
    it { should be_executable }
  end
end

describe file('/root/.rbenv/version') do
  its(:content) { should match(/1.9.3-p547/) }
end
