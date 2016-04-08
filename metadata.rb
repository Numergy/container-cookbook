# -*- coding: utf-8 -*-
name 'container'
maintainer 'Numergy'
maintainer_email 'cd@numergy.com'
license 'Apache 2.0'
description 'Installs/Configures docker containers for bamboo-worker'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

depends 'apt'
depends 'build-essential'
depends 'chrome'
depends 'jenv'
depends 'locale'
depends 'maven'
depends 'ndenv'
depends 'phpenv'
depends 'pyenv'
depends 'rbenv'
depends 'xvfb'

source_url 'https://github.com/Numergy/container-cookbook' if
  respond_to?(:source_url)
issues_url 'https://github.com/Numergy/container-cookbook/issues' if
  respond_to?(:issues_url)
