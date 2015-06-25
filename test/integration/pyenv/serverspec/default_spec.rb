# -*- coding: utf-8 -*-
require 'serverspec'
set :backend, :exec

bins = ['/usr/local/pyenv/shims/pip',
        '/usr/local/pyenv/shims/python',
        '/usr/local/pyenv/shims/tox',
        '/usr/local/pyenv/versions/2.7.6/bin/tox',
        '/usr/local/pyenv/versions/3.3.3/bin/tox']

bins.each do |command|
  describe file(command) do
    it { should be_file }
    it { should be_executable }
  end
end

describe file('/usr/local/pyenv/version') do
  its(:content) { should match(/2.7.6/) }
end
