package :nginx, :provides => :webserver do
  description 'Nginx Web Server'

#  requires :nginx_source_core, :nginx_init, :sites_folders, :nginx_conf
  requires :nginx_package, :sites_folders
end

package :nginx_dependencies do
  libraries = %w( python-software-properties )
  apt libraries
  
  verify do
    libraries.each {|library| has_apt library }
  end  
end

package :nginx_package do
  
  requires :nginx_dependencies
  runner "add-apt-repository ppa:nginx/stable"
  runner 'apt-get update'
  runner 'apt-get -y install nginx'
    
  
  verify do
#    has_executable '/usr/sbin/nginx'
  has_apt 'nginx'
  end
end

package :sites_folders do
#  requires :nginx_source_core
  
  requires :nginx_package

  verify do
    has_directory '/etc/nginx/sites-available'
    has_directory '/etc/nginx/sites-enabled'
  end
 
  runner "sed -i -r 's/default_server/ipv6only=on default_server/' /etc/nginx/sites-available/default"
  runner '/etc/init.d/nginx restart'
  
end



