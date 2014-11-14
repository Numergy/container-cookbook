# -*- coding: utf-8 -*-

require 'serverspec'
set :backend, :exec

describe file '/usr/bin/docker' do
  it { should be_file }
  it { should be_executable }
end
