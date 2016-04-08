# -*- coding: utf-8 -*-

machine_image 'ci_ruby' do
  role 'ruby'
  machine_options docker_options: {
    base_image: {
      name: 'ubuntu',
      repository: 'ubuntu',
      tag: '14.04'
    }
  }
end
