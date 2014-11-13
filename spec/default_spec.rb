# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'container::default' do
  subject { ChefSpec::Runner.new.converge(described_recipe) }
end
