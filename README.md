# Grokit Dev

This repository contains a comprehensive set of tools for getting started developing and testing with Grokit database engine.

## Contributors:

* Dax Gerts

## GrokitDev Box Overview

The following process will allow you to easily setup and run Ipython Notebooks in your browser without having to make a lot of permanent changes to your computer. This is accomplished by creating a "virtual machine" which runs on its own partioned section of your computer. The use of Vagrant allows this machine to be created from prepared files found in this repository and with a minimum of individual effort. Additionaly, a vagrant machine can be stopped, destroyed, and recreated at any given time.

## Installation and Setup

This process will take a few minutes and requires a good internet connection.

### 1. Install VirtualBox

Download and install VirtualBox [here](https://www.virtualbox.org/wiki/Downloads)

### 2. Install Vagrant

Download and install Vagrant [here](https://www.vagrantup.com/downloads.html)

### 2.5 Install the hosts-updater Vagrant plugin

```vagrant plugin install vagrant-hostsupdater```

You can read more about this at the [vagrant-hostupdater git page](https://github.com/cogitatio/vagrant-hostsupdater)

### 3. Download 'GrokitDev' Repository 

Use git to download the 'GrokitDev' Repository: (preferred)
 
Use ```git clone https://github.com/SlightlyUnorthodox/GrokitDev.git``` to create a local copy of the repository


### 4. Run Vagrant setup

This process will likely take several minutes when run for the first time, but will be significantly faster if ever needed again. Feel free to grab a cup of coffee while this completes.

What your computer is doing here:
 * Creating a virtual machine in your computer
 * Downloading and installing Ubuntu
 * Installing Git, Python, NLTK, and Grokit
 * Starting the Grokit server and forwarding that to the host machine at '127.0.0.1:8000'

#### Mac & Linux

Open the terminal using 

```{bash}
  cd ~/desktop/GrokitDev
  vagrant plugin install vagrant-hostsupdater
  vagrant up
```

[More info on Mac termainal](http://blog.teamtreehouse.com/introduction-to-the-mac-os-x-command-line)

#### Windows
```{cmd}
  cd ~\Desktop\GrokitDev
  vagrant plugin install vagrant-hostsupdater
  vagrant up
```

[More info on Windows command prompt](http://www.bleepingcomputer.com/tutorials/windows-command-prompt-introduction/)

## Access Grokit Server

The Grokit server can be accessed from the [localhost](http://localhost:8000)

## Access Your Vagrant Box Directly

#### Mac & Linux
```{bash}
  cd ~/desktop/GrokitDev
  vagrant ssh
```

[More info on Mac termainal](http://blog.teamtreehouse.com/introduction-to-the-mac-os-x-command-line)

#### Windows

On Windows, you'll likely need to use Putty to access your vagrant box.

* Hosname: localhost
* Port: 2222
* Username: vagrant
* Password: vagrant

## Check for Updates

```{bash}
  vagrant reload --provision
```

## More Info

If you're interested in learning more ways to use Vagrant, please read the tutorials [here](https://www.vagrantup.com/docs/getting-started/)
