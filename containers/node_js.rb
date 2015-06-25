# -*- coding: utf-8 -*-
machine 'node_js' do
  machine_options docker_options: {
    base_image: {
      name: 'ubuntu',
      repository: 'ubuntu',
      tag: '14.04'
    }
  }
  role 'node_js'
end
