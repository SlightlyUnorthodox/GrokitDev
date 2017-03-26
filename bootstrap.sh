# Run setup vagrant box setup
export DEBIAN_FRONTEND=noninteractive

#!/bin/bash

# Exit on first error
set -e

# Import helper functions
cd /vagrant && . bootstrap_functions.sh

# Change to working directory
cd /home/vagrant

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
sh -c "if cd gtStats; then echo 'gtStats already exists'; else git clone https://github.com/tera-insights/gtStats.git; fi"
sh -c "if cd gtSampling; then echo 'gtSampling already exists'; else git clone https://github.com/tera-insights/gtSampling.git; fi"
sh -c "if cd gtLearning; then echo 'gtLearning already exists'; else git clone https://github.com/tera-insights/gtLearning.git; fi"
sh -c "if cd gtJson; then echo 'gtJson already exists'; else git clone https://github.com/tera-insights/gtJson.git; fi"
sh -c "if cd translator; then echo 'translator already exists'; else git clone https://github.com/tera-insights/translator.git; fi"
sh -c "if cd gtTranslator; then echo 'gtTranslator already exists'; else git clone https://github.com/tera-insights/gtTranslator.git; fi"
sh -c "if cd gtTest; then echo 'gtTest already exists'; else git clone https://github.com/SlightlyUnorthodox/gtTest.git; fi"

# Make grokit prereqs directory and step inside
mkdir -p prereqs

# Run installation procedures
echo "RUNNING: 'install_prereqs'"
install_prereqs

# Run LEMON installation
echo "RUNNING: 'install_lemon'"
install_lemon

# Run ANTLR installation
echo "RUNNING: 'install_antlr'"
install_antlr

# Run Astyle installation
echo "RUNNING: 'install_astyle'"
install_astyle

# Run Websocketpp installation
echo "RUNNING: 'install_websocketpp'"
install_websocketpp

# Run MCT installation
echo "RUNNING: 'install_libmct'"
install_libmct

# Update ldconfig
echo "RUNNING: 'update_ldconfig'"
update_ldconfig

echo "RUNNING: 'confirm_pkg_config'"
confirm_pkg_config

# Run Grokit engine installation
echo "RUNNING: 'install_grokit'"
install_grokit

# Run Grokit base, 'gtBase' installation
echo "RUNNING: 'install_R_base'"
install_R_base

# Run Statistics library installation
echo "Running: 'install_statistics'"
install_statistics

# Run gtLearning library installation
echo "Running: 'install_gtLearning'"
install_gtLearning

# Run gtJson library installation
echo "Running: 'install_gtJson'"
install_gtJson

# Run gtStats library installation
echo "Running: 'install_gtStats'"
install_gtStats

# Run gtSampling library installation
echo "Running: 'install_gtSampling'"
install_gtSampling

# Run gtTranslator library installation
echo "Running: 'install_gtTranslator'"
install_gtTranslator

# Run Grokit build tests
echo "Running: 'run_build_tests'"
run_build_tests

echo "MESSAGE: Grokit Development Server Provisioned Successfully"