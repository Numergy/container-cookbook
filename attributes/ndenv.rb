# -*- coding: utf-8 -*-
#
# Cookbook Name:: container
# Attribute:: ndenv
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

node.default['container']['ndenv']['versions'] = ['0.10.26']
node.default['container']['ndenv']['global'] = '0.10.26'
node.default['container']['ndenv']['packages'] = ['grunt', 'grunt-cli', 'bower']