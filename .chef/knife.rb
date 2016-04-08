# See http://docs.opscode.com/config_rb_knife.html
# for more information on knife configuration options

require 'chef/provisioning/docker_driver'
driver 'docker'

current_dir = File.dirname(__FILE__)

log_level :info
log_location STDOUT
cache_type 'BasicFile'
cache_options(path: "#{ENV['HOME']}/.chef/checksums")
cookbook_path ["#{current_dir}/../cookbooks"]
role_path "#{current_dir}/../roles"
