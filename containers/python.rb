# -*- coding: utf-8 -*-

machine_image 'ci_python' do
  role 'python'
  machine_options docker_options: {
    base_image: {
      name: 'ubuntu',
      repository: 'ubuntu',
      tag: '14.04'
    }
  }
end
