# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  # Specify vagrant box and source url 
  config.vm.box = "centos/7"
 
  # Configure local network settings
  config.vm.hostname = "grokit.dev"
  #config.vm.network "private_network", type: :dhcp

  # Set machine alias
  config.hostsupdater.aliases = ["grokit.dev"]

  # Configure shared vagrant folder
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  # Set ssh forwarding off
  config.ssh.insert_key = false
  
  
  # Allow internal symlinks
  #config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]

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

  # Ensure that grokit is always running in 'offline' mode
  config.vm.provision "shell", run: 'always' do |s|
    s.inline = "export mode='offline'"
  end
  
  # Allow provisioning of bootstrap scripts
  config.vm.provision "shell" do |s|
    s.path = "bootstrap.sh"
  end



end
