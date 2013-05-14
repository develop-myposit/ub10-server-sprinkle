package :postgres, :provides => :database do
  description 'PostgreSQL database'
#  requires :postgres_setup_repo, :postgres_core, :postgres_user, :postgres_database, :postgres_autostart
  requires :postgres_dependencies, :postgres_package, :postgres_user
end

package :postgres_dependencies do
  libraries = %w( python-software-properties )
  apt libraries
  
  verify do
    libraries.each {|library| has_apt library }
  end  
end

package :postgres_package do
  
  requires :postgres_dependencies
  runner "add-apt-repository ppa:pitti/postgresql"
  runner 'apt-get update'
  runner 'apt-get -y install postgresql-9.2 libpq-dev'
    
  
  verify do
    has_executable 'psql'
    has_apt 'postgresql-9.2'
    has_apt 'libpq-dev'
  end
end
  
package :postgres_user do
  runner %{echo "CREATE ROLE #{DEPLOY_USER} WITH PASSWORD '#{DEPLOY_POSTGRES_PASSWORD}';" | sudo -u postgres psql}
  
  verify do
    @commands << "echo 'SELECT ROLNAME FROM PG_ROLES' | sudo -u postgres psql | grep #{DEPLOY_USER}"
  end
end

# package :postgres_database do
#   runner "sudo -u postgres createdb --owner=#{DEPLOY_USER} #{DB_NAME}"
  
#   verify do
#     @commands << "sudo -u postgres psql -l | grep #{DB_NAME}"
#   end  
# end
# 
# package :postgres_autostart do
#   description "PostgreSQL: Autostart on reboot"
#   requires :postgres_core
  
#   runner '/usr/sbin/update-rc.d postgresql-8.4 defaults'
# end

%w[start stop restart reload].each do |command|
  package :"postgres_#{command}" do
    requires :postgres_core

    runner "/etc/init.d/postgresql-9.2 #{command}"
  end
end