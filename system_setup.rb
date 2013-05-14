$: << File.dirname(__FILE__)

require 'config'
require 'lib/verifiers'
require 'packages/update'
require 'packages/git'
require 'packages/host'
require 'packages/deploy'
require 'packages/utilities'
require 'packages/ssh'
require 'packages/postgres'
require 'packages/nginx'
require 'packages/unicorn'
require 'packages/app'
require 'packages/ruby_install'
require 'packages/node'
require 'packages/app'

ASSETS_PATH = File.join(File.dirname(__FILE__), 'assets')

policy :stack, :roles => :app do
  requires :system_update
  requires :tools
  requires :host
  requires :deployer
  requires :node
  requires :scm
  requires :ruby              # Install ruby
  requires :database
  requires :webserver
  requires :ssh                # TODO: turn this on once policy is good.  It'll disable root login so make sure everything is good!
  requires :app
end

deployment do
  delivery :ssh do
    roles :app => HOSTIP
    user ROOT_USER
    password ROOT_USER_PASSWORD
  end

  source do
    prefix   '/usr/local'           # where all source packages will be configured to install
    archives '/usr/local/sources'   # where all source packages will be downloaded to
    builds   '/usr/local/build'     # where all source packages will be built
  end
end
