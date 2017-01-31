#!/bin/bash

function log() {
    echo -n "MSG: "
    echo $*
}

function install_prereqs() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Installing dependencies"
    apt-get update

    # Add key for php 5.4
    yes | sudo add-apt-repository ppa:ondrej/php5-oldstable
    # sudo apt-get install -y python-software-properties

    apt-get install -y \
        default-jdk \
        sqlite3 \
        libsqlite3-dev \
        subversion \
        autoconf \
        automake \
        libtool \
        libonig2 \
        libarmadill04 \
        r-base \
        clang-3.4 \
        apache2 \
        libapache2-mod-wsgi \
        php5

    # restart apache
    log "${FUNCNAME[0]}: Restarting apache server"
    service apache2 restart
}

# Download and install LEMON Graph Library
function install_lemon() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Downloading LEMON Graph Library"
    
    # Create subdirectory for lemon installation
    mkdir /vagrant/prereqs/lemon
    cd /vagrant/prereqs/lemon
    
    # Download LEMON graph library version 1.2.3 and unzip
    wget "http://lemon.cs.elte.hu/pub/sources/lemon-1.2.3.tar.gz" -O "lemon.tar.gz"
    tar xvzf "lemon.tar.gz"

    log "${FUNCNAME[0]}: Running LEMON config and make process"
    
    # Run lemon configuration and install
    ./lemon-1.2.3/configure
    make
    make check
    make install

    log "${FUNCNAME[0]}: LEMON successfully installed"
    
    # Return to vagrant directory
    cd /vagrant
}

function install_antlr() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Downloading ANTLR Version 3.4 from git archives"
    
    # Download and install ANTLR Parser Generator
    mkdir /vagrant/prereqs/antlr
    cd /vagrant/prereqs/antlr
    
    # Download ANTLR Parser Generator version 3.4
    wget "https://github.com/antlr/website-antlr3/raw/gh-pages/download/antlr-3.4-complete.jar"

    # Add ANTLR to CLASSPATH and run it
    export CLASSPATH=/vagrant/prereqs/antlr/antlr-3.4-complete.jar:$CLASSPATH
    
    # Add to .bashrc script
    #echo "export CLASSPATH=/vagrant/prereqs/antlr/antlr-3.4-complete.jar:$CLASSPATH" >> ~/.bashrc

    # Test antlr install
    java org.antlr.Tool -version

    # Add antlr3 as alias
    #sh -c "echo 'java -jar /vagrant/prereqs/antlr/antlr-3.4-complete.jar' > /usr/local/bin/antlr3"
    sh -c "echo 'java -cp /vagrant/prereqs/antlr/antlr-3.4-complete.jar org.antlr.Tool \$1 \$2' > /usr/local/bin/antlr3"
    chmod a+x /usr/local/bin/antlr3

    log "${FUNCNAME[0]}: ANTLR3 successfully installed"
    
    log "${FUNCNAME[0]}: Downloading ANTLR3 C Runtime from git arhives"
    
    # Download antlr C runtime
    svn checkout https://github.com/antlr/antlr3/trunk/runtime/C

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

function confirm_pkg_config() {
    
    log "Running ${FUNCNAME[0]}"

    # Export pkg-config files to PATH
    
    # Make local pkgconfig directory
    mkdir /vagrant/pkgconfig

    # pkg-config for antlr3
    echo "prefix=/usr
exec_prefix=${prefix}
libdir=/usr/local/bin
includedir=${prefix}/include

Name: Antlr 3 C Runtime
Description: The C runtime for the Antlr parser generator
Version: 3.4
Cflags: -I${includedir}
Libs: -L${libdir} -lantlr3c" > /vagrant/pkgconfig/antlr3c.pc
    export PKG_CONFIG_PATH=/vagrant/grokit/pkgconfig/antlr3c.pc
    
    # pkg-config for armadillo
    
    echo "prefix=/usr
exec_prefix=${prefix}
libdir=/usr/lib
includedir=${prefix}/include

Name: Armadillo
Description: A C++ Matrix and Linear Algebra library.
Version: 1.4.2
Cflags: -I${includedir}
Libs: -L${libdir} -larmadillo" > /vagrant/pkgconfig/armadillo.pc
    export PKG_CONFIG_PATH=/vagrant/pkgconfig/armadillo.pc

    # pkg-config for onig
    echo "prefix=/usr
exec_prefix=${prefix}
libdir=/usr/lib
includedir=${prefix}/include

Name: Oniguruma
Description: A C regular expression library
Version: 5.9.1
Cflags: -I${includedir}
Libs: -L${libdir} -lonig" > /vagrant/pkgconfig/onig.pc
    export PKG_CONFIG_PATH=/vagrant/pkgconfig/onig.pc

    log "${FUNCNAME[0]}: pkg-config files successfully added"
    
}

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

function install_gtbase() {

    # Go to gtbase 
    log "Running ${FUNCNAME[0]}"

    # Install gtBase on grokit system
    R CMD INSTALL /vagrant/gtBase
    log "${FUNCNAME[0]}: gtBase successfully installed"
    

}