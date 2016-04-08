# Container Cookbook


The Chef cookbook to build Docker containers for CI/CD workflows. [![Build Status](https://travis-ci.org/Numergy/container-cookbook.svg)](https://travis-ci.org/Numergy/container-cookbook)

## Usage

This cookbook provides some recipes to init and build containers.

Provided recipes are:

- ndenv
- phpenv
- pyenv
- rbenv
- jenv

### Example to build a container:

#### With Rake

This method only works if you have docker installed on your system.

```
$ bundle install
$ bundle exec rake container:create_ruby #-> or simply `create` to create all containers
$ bundle exec rake container:deploy_ruby[my_registry.com] #-> or simply `deploy` to deploy container to `my_registry.com`
```

It's also possible to directly create and deploy all containers.

```
$ bundle install
$ bundle exec rake container:all[my_registry.com]
```

#### With vagrant

```
$ vagrant up
...
$ vagrant ssh
vagrant@vagrant:~$ sudo -i
root@vagrant:~# cd /vagrant
root@vagrant:~# bundle exec berks vendor
root@vagrant:~# bundle exec rake container:create
```

###### You now have a docker image:

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
ci_ruby             latest              f8290ef73660        7 minutes ago       722.4 MB
```

###### Running our container:

```
$ docker run -t -i --entrypoint "/bin/bash" ci_ruby --login -c "rbenv versions"
* 1.9.3-p547 (set by /opt/rbenv/version)
  2.0.0-p598
  2.1.0
  2.1.5
```

More info about containers with chef: https://docs.chef.io/containers.html

## License and Authors

Authors:

- Antoine Rouyer <antoine.rouyer@numergy.com>
- Pierre Rambaud <pierre.rambaud@numergy.com>

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
