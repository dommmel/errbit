# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
set -e
set -x

cd
sudo apt-get update -y
sudo apt-get install \
  git-core \
  curl \
  mongodb \
  zlib1g-dev\
  build-essential\
  libssl-dev\
  libreadline-dev\
  libyaml-dev\
  libsqlite3-dev\
  sqlite3\
  libxml2-dev\
  libxslt1-dev\
  libcurl4-openssl-dev\
  python-software-properties \
  -y 2> /dev/null

# install node (the rails asset pipeline need it)
sudo add-apt-repository ppa:chris-lea/node.js -y
sudo apt-get update -y
sudo apt-get install nodejs -y 

# install rbenv
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# Setup rbenv paths
pathstring='export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH"'
eval $pathstring
echo $pathstring >> ~/.bashrc

# Init rbenv
initstring='eval "\$(rbenv init -)"'
echo $initstring >> ~/.bashrc
eval $initstring

# install ruby
rbenv install 2.1.2
rbenv global 2.1.2
ruby -v
echo "gem: --no-ri --no-rdoc" > ~/.gemrc

# install gems
gem install bundler foreman rails
rbenv rehash

SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"
  #config.vm.provider "virtualbox" do |v|
  # 	v.gui = true
  # end
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  #  v.cpus = 2
  end
  config.vbguest.auto_update = false
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  #if Dir.glob("#{File.dirname(__FILE__)}/.vagrant/machines/default/*/id/*").empty?
    config.vm.provision :shell, inline: $script, privileged: false
  #end

end
