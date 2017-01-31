# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  # Specify vagrant box
  config.vm.box = "ubuntu/trusty32"

  # Configure local network settings
  config.vm.hostname = "grokit.dev"
  
  # Set machine alias
  config.hostsupdater.aliases = ["grokit.dev"]

  # Specify host network address ## !! Change this to work for your machine !! ##
  config.vm.network "private_network", ip: "192.168.33.1"
 
  # Specify forward ports as needed
  #config.vm.network "forwarded_port", guest: 8000, host: 8080
  config.vm.network "forwarded_port", guest: 22, host: 22
  
  # Prevent password requests during setup
  #vagrant ALL=(ALL) NOPASSWD: ALL

  # Allow for Vagrant to forward ssh keys from host
  config.ssh.forward_agent = true

  # Disable synced folder (optional)
  #config.vm.synced_folder '.', '/vagrant', disabled: true

  # Allow provisioning of bootstrap scripts
  config.vm.provision "shell" do |s|
    s.path = "bootstrap.sh"
  end

end
