# -*- coding: utf-8 -*-
#
# Cookbook Name:: container
# Attribute:: rbenv
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.default['container']['rbenv']['versions'] = ['1.9.3-p547',
                                                  '2.0.0-p598',
                                                  '2.1.0',
                                                  '2.1.5']
node.default['container']['rbenv']['global'] = '1.9.3-p547'
node.default['container']['rbenv']['packages'] = %w(bundler)

default['container']['rbenv']['binaries_url'] = 'http://binaries.intercityup.com/ruby/ubuntu'
default['container']['rbenv']['available_binaries'] = %w(2.1.0)
