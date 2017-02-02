#!/bin/bash

# Define log messager function
function log() {
    echo -n "MSG: "
    echo $*
}

# Install general Ubuntu-friendly prerequisites
function install_prereqs() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Installing dependencies"

    # Add key for php 5.4
    yes | sudo add-apt-repository ppa:ondrej/php5-oldstable
    # sudo apt-get install -y python-software-properties

    # Add websocketpp distribution to package list
    sudo sh -c "if grep -q 'deb http://archive.ubuntu.com/ubuntu quantal main universe multiverse' /etc/apt/sources.list;
then echo 'Package list already updated';
else echo 'deb http://archive.ubuntu.com/ubuntu quantal main universe multiverse
deb http://archive.ubuntu.com/ubuntu quantal-updates main universe multiverse
deb http://security.ubuntu.com/ubuntu quantal-security main universe multiverse
deb http://archive.canonical.com/ubuntu quantal partner' >> /etc/apt/sources.list; fi"

    # Update package repository
    apt-get update
    apt-get upgrade

    # Install prerequisites that can be found in package repository
    apt-get install -y \
        default-jdk \
        sqlite3 \
        libsqlite3-dev \
        subversion \
        autoconf \
        automake \
        libtool \
        libarmadillo4 \
        r-base \
        clang-3.4 \
        apache2 \
        libapache2-mod-wsgi \
        php5 \
        php-pear \
        r-cran-rjson \
        pkg-config \
        libjsoncpp0 \
        libjsoncpp-dev \
        gcc \
        g++ \
        build-essential \
        libssl-dev \
        scons

    # Modify php configuration to allow short_open_tag
    echo "short_open_tag = On" > /etc/php5/cli/conf.d/30-short_open_tag.ini

    # Manage pear installations
    pear upgrade
    #pear install XML_UTIL
    #pear install STRUCTURES_GRAPH

    # restart apache
    log "${FUNCNAME[0]}: Restarting apache server"
    service apache2 restart

}

# Download and install LEMON Graph Library
function install_lemon() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Downloading LEMON Graph Library"
    
    # Download LEMON graph library version 1.2.3 and unzip
    cd /vagrant/prereqs
    wget "http://lemon.cs.elte.hu/pub/sources/lemon-1.2.3.tar.gz" -O "lemon.tar.gz"
    tar xvzf "lemon.tar.gz"

    # Step into un-tarred lemon dir
    cd /vagrant/prereqs/lemon-1.2.3

    log "${FUNCNAME[0]}: Running LEMON config and make process"
    
    # Run lemon configuration and install
    ./configure

    # Run make and install
    make
    #make check # Dependency bug in lemon 1.2.3
    make install 

    log "${FUNCNAME[0]}: LEMON successfully installed"
    
    # Return to vagrant directory
    cd /vagrant

}

# Install ANTLR3 and ANLTR3 C Runtime from archives
function install_antlr() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Downloading ANTLR Version 3.4 from git archives"
    
    # Download and install ANTLR Parser Generator
    mkdir -p /vagrant/prereqs/antlr
    cd /vagrant/prereqs/antlr
    
    # Download ANTLR Parser Generator version 3.4
    wget "https://github.com/antlr/website-antlr3/raw/gh-pages/download/antlr-3.4-complete.jar"

    # Add ANTLR to CLASSPATH and run it
    export CLASSPATH=/vagrant/prereqs/antlr/antlr-3.4-complete.jar:$CLASSPATH
    
    # Add to .bashrc script
    #echo "export CLASSPATH=/vagrant/prereqs/antlr/antlr-3.4-complete.jar:$CLASSPATH" >> ~/.bashrc

    # Test antlr install
    #java org.antlr.Tool -version

    # Add antlr3 as alias
    #sh -c "echo 'java -jar /vagrant/prereqs/antlr/antlr-3.4-complete.jar' > /usr/local/bin/antlr3"
    sh -c "echo 'java -cp /vagrant/prereqs/antlr/antlr-3.4-complete.jar org.antlr.Tool \$1 \$2' > /usr/local/bin/antlr3"
    chmod a+x /usr/local/bin/antlr3

    log "${FUNCNAME[0]}: ANTLR3 successfully installed"
    
    log "${FUNCNAME[0]}: Downloading ANTLR3 C Runtime from git arhives"
    
    # Confirm position
    cd /vagrant/prereqs/antlr

    # Download antlr C runtime
    svn checkout https://github.com/antlr/antlr3/trunk/runtime/C

    # Move into C runtime dir
    cd /vagrant/prereqs/antlr/C

    # Install C runtime
    autoreconf --install
    autoconf
    ./configure
    make
    make check

    log "${FUNCNAME[0]}: ANTLR3 C Runtime successfully installed"
    
    # Return to vagrant directory
    cd /vagrant

}

# Build and install Onigurama from source
function install_onig() {

    log "Running ${FUNCNAME[0]}"

    # Step into prereqs directory

    cd /vagrant/prereqs

    log "${FUNCNAME[0]}: Downloading onigurama repository"

    # Download oniguruma regex library
    svn checkout https://github.com/LuaDist/onig/trunk
    mv /vagrant/prereqs/trunk /vagrant/prereqs/onig

    # Step inside onig directory
    cd /vagrant/prereqs/onig

    log "${FUNCNAME[0]}: Configuring and making Oniguruma"

    # Configure and make
    ./configure
    make
    make install
    make atest

    log "${FUNCNAME[0]}: Oniguruma installed successfully"

    # Return to vagrant directory
    cd /vagrant

}

# Finish installation and configuration of websocketpp and pre-reqs
function install_websocketpp() {

    log "Running ${FUNCNAME[0]}"

    # Step into prereqs directory

    cd /vagrant/prereqs

    log "${FUNCNAME[0]}: Downloading boost 1.53.0 library"

    # Download boost and unzip
    wget http://sourceforge.net/projects/boost/files/boost/1.53.0/boost_1_53_0.tar.bz2/download -O boost_1_53_0.tar.bz2
    tar xvfj boost_1_53_0.tar.bz2 

    # Step into boost directory
    cd /vagrant/prereqs/boost_1_53_0

    log "${FUNCNAME[0]}: Installing boost 1.53.0 library"

    # Install boost
    ./bootstrap.sh --exec-prefix=/usr/local
    ./b2
    ./b2 install

    log "${FUNCNAME[0]}: Linking boost 1.53.0 library"

    # Link to libraries
    export LD_LIBRARY_PATH=/usr/local/lib
    export BOOST_ROOT=~/boost_1_53_0

    # Step back into prereqs
    cd /vagrant/prereqs

    log "${FUNCNAME[0]}: Downloading websocketpp library"

    # Get websocketpp library and unzip
    wget https://github.com/zaphoyd/websocketpp/archive/master.zip -O websocketpp.zip
    unzip websocketpp.zip

    # Copying websocketpp to /usr/include
    cp -r /vagrant/prereqs/websocketpp-master/websocketpp /usr/include/
    
    # Return to vagrant home
    cd /vagrant

    log "${FUNCNAME[0]}: websocketpp successfully installed"

}

# Define pkg-config files
function confirm_pkg_config() {
    
    log "Running ${FUNCNAME[0]}"

    # Export pkg-config files to PATH
    
    # Make local pkgconfig directory
    mkdir -p /vagrant/pkgconfig

    # pkg-config for antlr3
    echo "prefix=/usr
exec_prefix=\${prefix}
libdir=/usr/local/lib
includedir=\${prefix}/include

Name: Antlr 3 C Runtime
Description: The C runtime for the Antlr parser generator
Version: 3.4
Cflags: -I\${includedir}
Libs: -L\${libdir} -lantlr3c" > /vagrant/pkgconfig/antlr3c.pc

    # pkg-config for armadillo
    echo "prefix=/usr
exec_prefix=\${prefix}
libdir=/usr/lib
includedir=\${prefix}/include

Name: Armadillo
Description: A C++ Matrix and Linear Algebra library.
Version: 1.4.2
Cflags: -I\${includedir}
Libs: -L\${libdir} -larmadillo" > /vagrant/pkgconfig/armadillo.pc

    # pkg-config for onig
    echo "prefix=/usr
exec_prefix=\${prefix}
libdir=/usr/local/lib
includedir=\${prefix}/include

Name: Oniguruma
Description: A C regular expression library
Version: 5.9.1
Cflags: -I\${includedir}
Libs: -L\${libdir} -lonig" > /vagrant/pkgconfig/onig.pc

    # Set pkg-config search path
    export PKG_CONFIG_PATH=/vagrant/pkgconfig/

    log "${FUNCNAME[0]}: pkg-config files successfully added"
    
}

# Install grokit from repo src
function install_grokit() {
    
    log "Running ${FUNCNAME[0]}"

    # Go to grokit repo src code
    cd /vagrant/grokit/src

    # Compile datapath
    ./compile.datapath.sh

    log "${FUNCNAME[0]}: Grokit datapath successfully installed"
    
    # Return to home
    cd /vagrant  
}

# Install gtbase R files
function install_gtbase() {

    # Go to gtbase 
    log "Running ${FUNCNAME[0]}"

    # Install gtBase on grokit system
    R CMD INSTALL /vagrant/gtBase
    
    log "${FUNCNAME[0]}: gtBase successfully installed"
    

}