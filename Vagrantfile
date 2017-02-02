# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  # Specify vagrant box
  config.vm.box = "ubuntu/trusty64"

  # Configure local network settings
  config.vm.hostname = "grokit.dev"
  
  # Set machine alias
  config.hostsupdater.aliases = ["grokit.dev"]

  # Specify forward ports as needed
  #config.vm.network "forwarded_port", guest: 8000, host: 8080
  config.vm.network "forwarded_port", guest: 22, host: 22
  
  # Configure allocated vm resources
  ## !! Change this to work for your machine !! ##
  config.vm.provider "virtualbox" do |v|
    # Specify CPU usage cap for vm
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "70"]
    
    # Specify RAM allocated
    v.memory = 8192

    # Specify CPUs allocated
    v.cpus = 2
  end

  # Allow provisioning of bootstrap scripts
  config.vm.provision "shell" do |s|
    s.path = "bootstrap.sh"
  end



end
