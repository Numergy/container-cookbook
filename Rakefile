# -*- coding: utf-8 -*-
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

def run_command(command)
  if File.exist?('Gemfile.lock')
    sh %(bundle exec #{command})
  else
    sh %(chef exec #{command})
  end
end

task :vendor, [:directory] do |_t, args|
  directory = args[:directory] || 'cookbooks'
  rm_rf directory
  run_command "berks vendor #{directory}"
end

namespace :test do
  desc 'Tests suites runner'

  task checkstyle: [:foodcritic, :rubocop]
  task specs: [:chefspec]

  task :foodcritic do
    run_command 'foodcritic -f any .'
  end

  task :rubocop do
    run_command :rubocop
  end

  task :chefspec do
    run_command 'rspec ./spec/ --color --format documentation'
  end

  task :kitchen do
    run_command 'kitchen test'
  end
end

namespace :container  do
  current_dir = File.dirname(__FILE__)
  containers = %w(java node_js php python ruby)
  containers.each do |name|
    task "create_#{name}".to_sym do
      run_command("chef-client -z #{current_dir}/containers/docker_config.rb" \
                  " #{current_dir}/containers/#{name}.rb")
    end

    task "deploy_#{name}".to_sym, [:repository] do |_t, args|
      repository = "#{args[:repository]}/" unless args[:repository].nil?
      sh "docker tag -f $(docker images chef | grep #{name} | " \
      "awk '{ print $3 }') #{repository}#{name}-builder"
      sh "docker push #{repository}#{name}-builder"
    end
  end

  multitask create: containers.map { |name, _recipe| "create_#{name}".to_sym }

  task :deploy, [:repository] do |_t, args|
    repository = "#{args[:repository]}" unless args[:repository].nil?
    containers.each do |name, _recipe|
      task "deploy_#{name}_m".to_sym do
        Rake::Task["container:deploy_#{name}".to_sym].invoke(repository)
      end
    end

    multitask parallel_deploy:
      containers.map { |name, _recipe| "deploy_#{name}_m".to_sym }
    Rake::MultiTask[:parallel_deploy].invoke
  end

  task :all, [:repository] => [:create, :deploy]
end

task default: ['test:checkstyle', 'test:specs']
