# GrokitDev Overview

This repository contains a comprehensive installation procedure for installing and configuring the Grokit database engine.

The use of Vagrant allows this machine to be created from prepared files found in this repository and with a minimum of individual effort. Additionaly, a vagrant machine can be stopped, destroyed, and recreated at any given time.

## Installation and Setup

This process will take a non-trivial amount of time and requires a stable internet connection. The following steps should provide relatively complete instructions, but please raise an issue if there is an obvious gap or unaddressed problem.

### 1. Install VirtualBox

Download and install VirtualBox [here](https://www.virtualbox.org/wiki/Downloads)

### 2. Install Vagrant

Download and install Vagrant [here](https://www.vagrantup.com/downloads.html)

#### 2.5 Install Vagrant Plugins

The following are required plugins for GrokitDev to run.

```{bash}
vagrant plugin install vagrant-hostsupdater, vagrant-vbguest
```

The following are optional, but useful, plugins for Vagrant.

```{bash}
vagrant plugin install vagrant-triggers, vagrant-share, vagrant-sshfs
```

You can read more about this at the [vagrant-hostupdater git page](https://github.com/cogitatio/vagrant-hostsupdater)

### 3. Download 'GrokitDev' Repository 

Use ```git clone https://github.com/SlightlyUnorthodox/GrokitDev.git``` to create a local copy of the repository

#### 3.5 Modify Vagrantfile to Optimize for Your Machine

The Vagrantfile is currently configured to run with the following hardware settings, but you will likely want to change the settings depending on your hardware specifications and other system requirements.

```{bash}
# Specify CPU usage cap for vm
v.customize ["modifyvm", :id, "--cpuexecutioncap", "70"]

# Specify RAM allocated
v.memory = 8192

# Specify CPUs allocated
v.cpus = 2
```

### 4. Run Vagrant setup

This process will likely take a **non-trivial amount of time** when run for the first time, but will be significantly faster if ever needed again. Feel free to grab a cup of coffee (and maybe take a long lunch) while this process runs.

What's going on here:
 * Creating a virtual machine in your computer
 * Downloading and installing CentOS 7
 * Installing the long list of dependencies specificied in 'dependencies.md'

#### Mac & Linux Systems

Open the terminal using 

```{bash}
  cd /path/to/GrokitDev
  vagrant plugin install vagrant-hostsupdater
  vagrant up
```
#### Windows
```{cmd}
  cd \path\to\GrokitDev
  vagrant plugin install vagrant-hostsupdater
  vagrant up
```

## Accessing the GrokitDev instance

#### Mac & Linux
```{bash}
  cd /path/to/GrokitDev
  vagrant ssh
```
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
