package :ruby_build, :provides => :ruby do
  description 'Install ruby from source'
  
  requires :install_ruby, :add_bundler
end

package :install_ruby do
  description 'Ruby Virtual Machine'
  
  requires :ruby_essentials
  
  source "ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-#{RUBY_VERSION}.tar.gz" 
  
  verify do
    has_executable 'ruby'
    ruby_can_load 'rubygems'
  end
end

package :add_bundler do
  description 'Gems for Ruby'

  gem 'bundler'

  requires :install_ruby

  verify do
    ruby_can_load 'bundler'
  end
end