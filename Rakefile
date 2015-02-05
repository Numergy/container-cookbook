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

def bundle_exec(command)
  sh "bundle exec #{command}"
end

task :vendor, [:directory] do |_t, args|
  directory = args[:directory] || 'cookbooks'
  rm_rf directory
  bundle_exec "berks vendor #{directory}"
end

namespace :test do
  desc 'Tests suites runner'

  task checkstyle: [:foodcritic, :rubocop]
  task specs: [:chefspec]

  task :foodcritic do
    bundle_exec 'foodcritic -f any .'
  end

  task :rubocop do
    bundle_exec :rubocop
  end

  task :chefspec do
    bundle_exec 'rspec ./spec/ --color --format documentation'
  end

  task :kitchen do
    bundle_exec 'kitchen test'
  end
end

namespace :container  do
  current_dir = File.dirname(__FILE__)
  h = { 'java' => 'jenv',
        'node_js' => 'ndenv',
        'php' => 'phpenv',
        'python' => 'pyenv',
        'ruby' => 'rbenv' }

  h.each do |name, recipe|
    task "prepare_#{name}".to_sym => [:vendor] do
      sh "knife container docker init builder/#{name} -r " \
      "'recipe[container::#{recipe}]' " \
      "--cookbook-path #{current_dir}/cookbooks" \
      " --dockerfiles-path #{current_dir}/dockerfiles -z --force"
      sh "tar -zc --exclude .git --directory #{current_dir} cookbooks" \
      " | tar -xz -C #{current_dir}/dockerfiles/builder/#{name}/chef/"
    end

    task "create_#{name}".to_sym do
      sh "knife container docker build builder/#{name} --no-berks" \
      " -z --dockerfiles #{current_dir}/dockerfiles/"
    end

    task "deploy_#{name}".to_sym, [:repository] do |_t, args|
      repository = "#{args[:repository]}/" unless args[:repository].nil?
      sh "docker tag -f $(docker images | grep builder/#{name} | " \
      "grep latest | awk '{ print $3 }') #{repository}#{name}-builder"
      sh "docker push #{repository}#{name}-builder"
    end
  end

  multitask prepare: h.map { |name, _recipe| "prepare_#{name}".to_sym }
  multitask create: h.map { |name, _recipe| "create_#{name}".to_sym }

  task :deploy, [:repository] do |_t, args|
    repository = "#{args[:repository]}/" unless args[:repository].nil?
    h.each do |name, _recipe|
      task "deploy_#{name}_m".to_sym do
        Rake::Task["container:deploy_#{name}".to_sym].invoke(repository)
      end
    end

    multitask parallel_deploy: h.map { |name, _recipe| "deploy_#{name}_m".to_sym }
    Rake::MultiTask[:parallel_deploy].invoke
  end

  task :all, [:repository] => [:prepare, :create, :deploy]
end

task default: ['test:checkstyle', 'test:specs']
