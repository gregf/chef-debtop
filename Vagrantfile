# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "chef/debian-7.7"

  config.vm.synced_folder ".", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = '4'
    vb.memory = "1024"
  end

  config.vm.provision "shell", inline: <<-SHELL
    cd /vagrant_data &&
    sudo ./bootstrap.sh
  SHELL
end
