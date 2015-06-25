# -*- coding: utf-8 -*-
require 'serverspec'
set :backend, :exec

describe user('jenv') do
  it { should_not exist }
end

describe group('jenv') do
  it { should_not exist }
end

describe file('/opt/jenv/versions/1.6') do
  it { should be_directory }
end

describe file('/opt/jenv/versions/1.7') do
  it { should be_directory }
end

describe file('/opt/jenv/version') do
  its(:content) { should match(/1\.7/) }
end
