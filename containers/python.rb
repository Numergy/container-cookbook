# -*- coding: utf-8 -*-
machine 'python' do
  machine_options docker_options: {
    base_image: {
      name: 'ubuntu',
      repository: 'ubuntu',
      tag: '14.04'
    }
  }
  role 'python'
end
