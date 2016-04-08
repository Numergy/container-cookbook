# -*- coding: utf-8 -*-

machine_image 'ci_php' do
  role 'php'
  machine_options docker_options: {
    base_image: {
      name: 'ubuntu',
      repository: 'ubuntu',
      tag: '14.04'
    }
  },
  docker_connection: {
    read_timeout: 10000
  }
end
