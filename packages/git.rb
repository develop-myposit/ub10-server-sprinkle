package :git, :provides => :scm do
  description 'Git'
  runner "add-apt-repository ppa:pdoes/ppa"
  runner 'apt-get update'
  runner 'apt-get -y install git'
    
  verify do
    has_executable 'git'
  end
end