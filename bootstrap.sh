# Run setup vagrant box setup
export DEBIAN_FRONTEND=noninteractive

#!/bin/bash

# Exit on first error
set -e

# Change to working directory
cd /vagrant

# Check git installation
apt-get update
apt-get install -y git

# Clone copies of the Grokit backend and base libraries
sh -c "if cd grokit; then git pull; else git clone https://github.com/tera-insights/grokit.git; fi"
sh -c "if cd gtBase; then git pull; else git clone https://github.com/tera-insights/gtBase.git; fi"

# Import helper functions
. bootstrap_functions.sh

# Run installation procedures
echo "RUNNING: 'install_prereqs'"
install_prereqs

# Make grokit prereqs directory and step inside
mkdir -p prereqs
cd prereqs

# Install and configure grokit engine prereqs
echo "RUNNING: 'install_lemon'"
install_lemon

echo "RUNNING: 'install_antlr'"
install_antlr

echo "RUNNING: 'confirm_pkg_config'"
confirm_pkg_config

# Run Grokit engine installation
echo "RUNNING: 'install_grokit'"
install_grokit

# Run Grokit base, 'gtBase' installation
echo "RUNNING: 'install_gtbase'"
install_gtbase

echo "MESSAGE: Grokit Development Server Provisioned Successfully"