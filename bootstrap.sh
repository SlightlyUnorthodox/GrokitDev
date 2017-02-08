# Run setup vagrant box setup
export DEBIAN_FRONTEND=noninteractive

#!/bin/bash

# Exit on first error
set -e

# Change to working directory
cd /vagrant

# Update yum packages
yum -y update

# Install dnf
yum install -y epel-release
yum install -y dnf

# Check git installation
yum install -y git svn

# Install
# Clone copies of the Grokit backend, R base, and Statistics libraries
sh -c "if cd grokit; then echo 'grokit already exists'; else git clone https://github.com/tera-insights/grokit.git; fi"
sh -c "if cd gtBase; then echo 'gtBase already exists'; else git clone https://github.com/tera-insights/gtBase.git; fi"
sh -c "if cd statistics; then echo 'statistics already exists'; else git clone https://github.com/tera-insights/statistics.git; fi"

# Import helper functions
. bootstrap_functions.sh

# Run installation procedures
echo "RUNNING: 'install_prereqs'"
install_prereqs

# Run LEMON installation
echo "RUNNING: 'install_lemon'"
install_lemon

# Run ANTLR installation
echo "RUNNING: 'install_antlr"
install_antlr

# Run Astyle installation
echo "RUNNING: 'install_astyle"
install_astyle

# Run Websocketpp installation
echo "RUNNING: 'install_websocketpp"
install_websocketpp

echo "RUNNING: 'confirm_pkg_config'"
confirm_pkg_config

# Run Grokit engine installation
echo "RUNNING: 'install_grokit'"
install_grokit

# Run Statistics library installation
echo "Running: 'install_statistics'"
install_statistics

# Run Grokit base, 'gtBase' installation
echo "RUNNING: 'install_R_base'"
install_R_base

echo "MESSAGE: Grokit Development Server Provisioned Successfully"