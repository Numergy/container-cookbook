machine 'node_js' do
  machine_options docker_options: {
    base_image: {
      name: 'ubuntu',
      repository: 'ubuntu',
      tag: '14.04'
    }
  }
  recipe 'container::ndenv'
end
