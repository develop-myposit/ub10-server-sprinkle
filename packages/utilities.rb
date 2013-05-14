
package :utilities, :provides => :tools do
  description "Tools: Common tools and libraries needed by applications or for operations"

  requires :build_essential, :ntp, :curl, :vim,
            :rsync, :debconf_utils, :tree, :python_utils,
            :ruby_essentials
end


package :build_essential do
  description 'build_essential'
  
  apt 'build-essential' do
    post :install, 'apt-get update && apt-get -y upgrade'
  end

  verify do
    has_apt 'build-essential'
  end
end

package :python_utils do
description 'python-software-properties'
 apt 'python-software-properties'
  
 verify do
    has_apt 'python-software-properties'
  end
end

package :debconf_utils do
  description 'debconf-utils'
  
  apt 'debconf-utils'

  verify do
    has_executable 'debconf-get-selections'
  end
end

package :ntp do
  description 'ntp'
  
  apt 'ntp' do
    post :install, 'ntpdate ntp.ubuntu.com'
  end

  verify do
    has_executable 'ntpdate'
  end
end

package :curl do
  description 'curl'
  
  apt 'curl'

  verify do
    has_executable 'curl'
  end
end

package :vim do
  description 'vim'
  
  apt 'vim'
  
  verify do
    has_executable 'vim'
  end
end

package :rsync do
  description 'rsync'

  apt 'rsync'

  verify do
    has_executable 'rsync'
  end
end

package :tree do
  description 'tree'

  apt 'tree'

  verify do
    has_executable 'tree'
  end
end

package :ruby_essentials do
   description 'Ruby Virtual Machine Build Dependencies'

    apt 'zlib1g-dev'
    apt 'zlib1g'
    apt 'libssl-dev'
    apt 'libreadline5-dev'
    apt 'libncurses5-dev'
    apt 'file'
    apt 'bison'
    apt 'libtool'
    apt 'automake'
    apt 'libc6-dev'
    apt 'libyaml-dev'
    apt 'libxml2-dev'
    apt 'libxslt1-dev'
    apt 'autoconf'
    apt 'libx11-dev'
    apt 'libffi-dev'
    apt 'tcl-dev'
    apt 'tk-dev'

  verify do
    has_apt 'zlib1g-dev'
    has_apt 'zlib1g'
    has_apt 'libssl-dev'
    has_apt 'libreadline5-dev'
    has_apt 'libncurses5-dev'
    has_apt 'file'
    has_apt 'bison'
    has_apt 'libtool'
    has_apt 'automake'
    has_apt 'libc6-dev'
    has_apt 'libyaml-dev'
    has_apt 'libxml2-dev'
    has_apt 'libxslt1-dev'
    has_apt 'autoconf'
    has_apt 'libx11-dev'
    has_apt 'libffi-dev'
    has_apt 'tcl-dev'
    has_apt 'tk-dev'
  end
end