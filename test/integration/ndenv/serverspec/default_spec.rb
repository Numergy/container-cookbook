# -*- coding: utf-8 -*-

require 'spec_helper'

capabilities = ['/root/.ndenv/shims/npm',
                '/root/.ndenv/shims/node',
                '/root/.ndenv/shims/bower',
                '/root/.ndenv/shims/grunt',
                '/root/.ndenv/versions/v0.10.26/bin/bower',
                '/root/.ndenv/versions/v0.10.26/bin/grunt']

describe file '/root/.ndenv/versions/v0.10.26' do
  it { should be_directory }
end

describe file '/root/.ndenv/version' do
  its(:content) { should match(/v0.10.26/) }
end

capabilities.each do |command|
  describe file(command) do
    it { should be_file }
    it { should be_executable }
  end
end
