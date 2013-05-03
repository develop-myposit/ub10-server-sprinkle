$: << File.dirname(__FILE__)

require 'config'
require 'lib/verifiers'
require 'packages/update'
require 'packages/git'
require 'packages/host'
require 'packages/deploy'
require 'packages/init'
require 'packages/ufw'
require 'packages/utilities'
require 'packages/ssh'
# require 'packages/timezone'
require 'packages/postgres'
require 'packages/nginx'
require 'packages/unicorn'
require 'packages/app'
require 'packages/ruby'
require 'packages/rbenv'

ASSETS_PATH = File.join(File.dirname(__FILE__), 'assets')

policy :stack, :roles => :app do
  requires :initialize
  requires :system_update
 # requires :timezone           # TODO:  Not sure if this is actually needed
  requires :host
  requires :deployer
  requires :scm
  requires :ruby               # TODO: Resolve issues with verifying rvm install
  requires :database
  requires :appserver
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
