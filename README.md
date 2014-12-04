Container Cookbook
==================
The Chef cookbook to build Docker containers for CI/CD workflows. [![Build Status](https://travis-ci.org/Numergy/container-cookbook.svg)](https://travis-ci.org/Numergy/container-cookbook)  

Usage
-----
This cookbook provides some recipes to init and build containers.  

Provided recipes are:  
- ndenv  
- phpenv  
- pyenv  
- rbenv  

Building containers
-------------------
The `builder` recipe can be used to spawn a builder vm, this recipe install all requirements to work with `knife-container`.  
If you are a vagrant user, you can use the `Vagrantfile` at the root of the repository, it will create an Ubuntu 14.04 and apply
`container::builder` recipe.  

After vm converged, you can ssh and play with `knife container` commands.  

##### Example to build a ruby container:  

###### First, install dependencies:  
```
$ bundle install
$ bundle exec berks vendor cookbooks
```

###### And run vagrant:  
```
$ vagrant up
...
$ vagrant ssh
vagrant@vagrant:~$ sudo su -
root@vagrant:~# knife container docker init builder/ruby -r 'recipe[container::rbenv]' --cookbook-path /vagrant/cookbooks --dockerfiles-path /vagrant/dockerfiles -z --force
root@vagrant:~# cp -r /vagrant/cookbooks/ /vagrant/dockerfiles/builder/ruby/chef/
root@vagrant:~# knife container docker build builder/ruby --no-berks -z --dockerfiles /vagrant/dockerfiles/
```

###### You now have a docker image:  
```
root@vagrant:~# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
builder/ruby        latest              f8290ef73660        7 minutes ago       722.4 MB
...
```

###### Running our container:  
```
root@vagrant:~# docker run -d builder/ruby
bc48f4d6aa4dd55c8013572996626c9597395f5d7c57be3b30556029990c6112
root@vagrant:~# docker ps
CONTAINER ID        IMAGE                 COMMAND                CREATED             STATUS              PORTS               NAMES
bc48f4d6aa4d        builder/ruby:latest   "chef-init --onboot"   6 seconds ago       Up 5 seconds                            cranky_mccarthy
root@vagrant:~# docker exec bc48f4d6aa4d su -l root -c "rbenv versions"
stdin: is not a tty
* 1.9.3-p547 (set by /opt/rbenv/version)
  2.0.0-p598
  2.1.0
  2.1.5
```
or
```
root@vagrant:~# docker run -t -i --entrypoint "/bin/bash" builder/ruby --login -c "rbenv versions"
* 1.9.3-p547 (set by /opt/rbenv/version)
  2.0.0-p598
  2.1.0
  2.1.5
```

More info about containers with chef: https://docs.getchef.com/containers.html

License and Authors
-------------------
Authors:
- Antoine Rouyer <antoine.rouyer@numergy.com>

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

