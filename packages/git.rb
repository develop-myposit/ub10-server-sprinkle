package :git, :provides => :scm do
  description 'Git'
  
  requires :git_core
  optional :tig
end

package :git_core do
  description "Git Core"
  apt 'git-core'
  
  verify do
    has_executable 'git'
  end
end

package :tig do
  description "Tig - ncurses interface for git"
  apt 'tig'
  
  verify do
    has_executable 'tig'
  end
end