machine 'ruby' do
  machine_options docker_options: {
    base_image: {
      name: 'ubuntu',
      repository: 'ubuntu',
      tag: '14.04'
    }
  }
  recipe 'container::rbenv'
end
