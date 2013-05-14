package :node do
  description 'Node Javascript Environment'
  runner "add-apt-repository ppa:chris-lea/node.js"
  runner 'apt-get update'
  runner 'apt-get -y install nodejs'
    
  
  verify do
    has_directory '/usr/lib/nodejs'
  end
end
