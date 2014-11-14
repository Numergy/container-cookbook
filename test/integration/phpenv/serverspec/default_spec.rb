# -*- coding: utf-8 -*-

require 'serverspec'
set :backend, :exec

describe file('/root/.phpenv/version') do
  its(:content) { should match(/5.3.29/) }
end
