# -*- coding: utf-8 -*-

require 'spec_helper'

describe file('/root/.phpenv/version') do
  its(:content) { should match(/5.3.29/) }
end
