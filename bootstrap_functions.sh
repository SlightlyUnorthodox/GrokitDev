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

    # Mass installation of prerequisite tools and libraries
    dnf -y -v groupinstall "C Development Tools and Libraries"
    dnf -y -v install bc wget clang java \
    php-cli php-pdo php-pecl-xdebug php-pear \
    jsoncpp jsoncpp-devel \
    sqlite sqlite-devel \
    openssl openssl-devel \
    oniguruma oniguruma-devel \
    boost boost-devel boost-system \
    R \
    armadillo-devel \
    emacs htop \
    libstdc++.so.6

    #rpm -ivh astyle

    # Install remaining pre-reqs through yum
    yum install -y autoconf \
    automake \
    libtool \
    glibc.i686 \
    ncurses-libs.i686 \
    bison \
    flex \
    glibc.devel.i686 \
    bzr \
    gperftools-libs.x86_64 \
    gperftools-devel.x86_64

    # Modify php configuration to allow short_open_tag
    echo "short_open_tag = On" > /etc/php.d/30-short_open_tag.ini

}

# Download and install LEMON Graph Library
function install_lemon() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Downloading LEMON Graph Library"
    
    # Download LEMON graph library version 1.2.3 and unzip
    cd /home/vagrant/prereqs
    wget -q "http://lemon.cs.elte.hu/pub/sources/lemon-1.2.3.tar.gz" -O "lemon.tar.gz"
    tar xvzf "lemon.tar.gz"

    # Step into un-tarred lemon dir
    cd /home/vagrant/prereqs/lemon-1.2.3

    log "${FUNCNAME[0]}: Running LEMON config and make process"
    
    # Run lemon configuration and install
    ./configure

    # Run make and install
    make
    #make check # Dependency bug in lemon 1.2.3
    make install 

    log "${FUNCNAME[0]}: LEMON successfully installed"
    
    # Return to vagrant directory
    cd /home/vagrant/

}

# Install ANTLR3 and ANLTR3 C Runtime from archives
function install_antlr() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Downloading ANTLR Version 3.4 from git archives"
    
    # Download and install ANTLR Parser Generator
    mkdir -p /home/vagrant/prereqs/antlr
    cd /home/vagrant/prereqs/antlr
    
    # Download ANTLR Parser Generator version 3.4
    wget -q "https://github.com/antlr/website-antlr3/raw/gh-pages/download/antlr-3.4-complete.jar"

    # Add ANTLR to CLASSPATH and run it
    export CLASSPATH=/home/vagrant/prereqs/antlr/antlr-3.4-complete.jar:$CLASSPATH
    
    # Add to .bashrc script
    #echo "export CLASSPATH=/home/vagrant/prereqs/antlr/antlr-3.4-complete.jar:$CLASSPATH" >> /home/vagrant/.bashrc

    # Test antlr install
    #java org.antlr.Tool -version

    # Add antlr3 as command to usr and sudo path
    #sh -c "echo 'java -jar /home/vagrant/prereqs/antlr/antlr-3.4-complete.jar' > /usr/local/bin/antlr3"
    sh -c "echo 'java -cp /home/vagrant/prereqs/antlr/antlr-3.4-complete.jar org.antlr.Tool \$*' > /usr/local/bin/antlr3"
    chmod a+x /usr/local/bin/antlr3

    sh -c "echo 'java -cp /home/vagrant/prereqs/antlr/antlr-3.4-complete.jar org.antlr.Tool \$*' > /usr/sbin/antlr3"
    chmod a+x /usr/sbin/antlr3

    log "${FUNCNAME[0]}: ANTLR3 successfully installed"
    
    log "${FUNCNAME[0]}: Downloading ANTLR3 C Runtime from git arhives"
    
    # Confirm position
    cd /home/vagrant/prereqs/antlr

    # Download antlr C runtime
    svn checkout --force https://github.com/antlr/antlr3/trunk/runtime/C

    # Move into C runtime dir
    cd /home/vagrant/prereqs/antlr/C

    # Install C runtime
    autoreconf --install
    autoconf
    ./configure --enable-64bit
    make
    make install
    make check

    log "${FUNCNAME[0]}: ANTLR3 C Runtime successfully installed"
    
    # Return to vagrant directory
    cd /home/vagrant/

}

# Build and install Onigurama from source
function install_onig() {

    log "Running ${FUNCNAME[0]}"

    # Step into prereqs directory

    cd /home/vagrant/prereqs

    log "${FUNCNAME[0]}: Downloading onigurama repository"

    # Remove onig if exists
    [ -e /home/vagrant/prereqs/onig ] && rm -r /home/vagrant/prereqs/onig

    # Download oniguruma regex library
    svn checkout https://github.com/LuaDist/onig/trunk
    mv /home/vagrant/prereqs/trunk /home/vagrant/prereqs/onig

    # Step inside onig directory
    cd /home/vagrant/prereqs/onig

    log "${FUNCNAME[0]}: Configuring and making Oniguruma"

    # Configure and make
    ./configure
    make
    make install
    make atest

    log "${FUNCNAME[0]}: Oniguruma installed successfully"

    # Return to vagrant directory
    cd /home/vagrant/

}

# Build and install Astyle from source
function install_astyle() {
    
    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Downloading Astyle from "
    
    mkdir -p /home/vagrant/prereqs/astyle
    cd /home/vagrant/prereqs/astyle
    
    # Download Astyle 2.06
    wget -q https://sourceforge.net/projects/astyle/files/astyle/astyle%202.06/astyle_2.06_linux.tar.gz/download -O astyle.tar.gz
    tar xvzf astyle.tar.gz

    # Make astyle for gcc
    cd /home/vagrant/prereqs/astyle/astyle/build/gcc
    make release shared static
    make install 

    # Make astyle for clang
    cd /home/vagrant/prereqs/astyle/astyle/build/clang
    make release shared static
    make install
    
    log "${FUNCNAME[0]}: Astyle successfully installed"
    
    # Go back to working directory
    cd /home/vagrant/
}   

# Finish installation and configuration of websocketpp and pre-reqs
function install_websocketpp() {

    log "Running ${FUNCNAME[0]}"

    # Step into prereqs directory

    cd /home/vagrant/prereqs

    log "${FUNCNAME[0]}: Downloading websocketpp library"

    # Get websocketpp library and unzip
    wget -q https://github.com/zaphoyd/websocketpp/archive/experimental.zip -O websocketpp.zip
    unzip -o websocketpp.zip

    # Copying websocketpp to /usr/include
    cp -r /home/vagrant/prereqs/websocketpp-experimental/websocketpp /usr/include/
    
    # Return to vagrant home
    cd /home/vagrant/

    log "${FUNCNAME[0]}: websocketpp successfully installed"

}

# Install MCT from Launchpad
function install_libmct() {

    log "Running ${FUNCNAME[0]}"

    # Step into prereqs directory

    cd /home/vagrant/prereqs

    log "${FUNCNAME[0]}: Downloading MCT library"

    # Remove mct if exists
    [ -e /home/vagrant/prereqs/libmct1.6 ] && rm -r /home/vagrant/prereqs/libmct1.6
    [ -e /home/vagrant/prereqs/1.6 ] && rm -r /home/vagrant/prereqs/1.6

    # Get libmct 1.6 from launchpad branch
    bzr branch lp:libmct/1.6
    mv 1.6 libmct1.6

    log "${FUNCNAME[0]}: Building MCT in /usr/local"

    cd /home/vagrant/prereqs/libmct1.6
    make install

     # Return to vagrant home
    cd /home/vagrant/

    log "${FUNCNAME[0]}: MCT Built successfully"

}

# Update 
function update_ldconfig() {

    log "Running ${FUNCNAME[0]}"

    # Establish symlnks for anltlr3c.so
    echo "/usr/local/lib
    /usr/lib" > /etc/ld.so.conf.d/usr-local.conf
    
    # Rebuild ld cache
    rm -f /etc/ld.so.cache
    ldconfig

    log "${FUNCNAME[0]}: ldconfig Updated"

}

# Define pkg-config files
function confirm_pkg_config() {
    
    log "Running ${FUNCNAME[0]}"

    # Export pkg-config files to PATH
    
    # Make local pkgconfig directory
    mkdir -p /home/vagrant/pkgconfig

    # pkg-config for antlr3
    echo "prefix=/usr/local
    exec_prefix=\${prefix}
    libdir=/usr/local/lib
    includedir=\${prefix}/include

    Name: Antlr 3 C Runtime
    Description: The C runtime for the Antlr parser generator
    Version: 3.4
    Cflags: -I\${includedir}
    Libs: -L\${libdir} -lantlr3c" > /home/vagrant/pkgconfig/antlr3c.pc

    # pkg-config for armadillo
    echo "prefix=/usr
    exec_prefix=\${prefix}
    libdir=/usr/lib64
    includedir=\${prefix}/include

    Name: Armadillo
    Description: A C++ Matrix and Linear Algebra library.
    Version: 4.3.2
    Cflags: -I\${includedir}
    Libs: -L\${libdir} -larmadillo" > /home/vagrant/pkgconfig/armadillo.pc

    # pkg-config for onig
    echo "prefix=/usr
    exec_prefix=\${prefix}
    libdir=/usr/lib64
    includedir=\${prefix}/include

    Name: Oniguruma
    Description: A C regular expression library
    Version: 5.9.5
    Cflags: -I\${includedir}
    Libs: -L\${libdir} -lonig" > /home/vagrant/pkgconfig/onig.pc

    # Set pkg-config search path
    export PKG_CONFIG_PATH=/home/vagrant/pkgconfig/

    log "${FUNCNAME[0]}: pkg-config files successfully added"
    
}

# Install grokit from repo src
function install_grokit() {
    
    log "Running ${FUNCNAME[0]}"

    # Go to grokit repo src code
    cd /home/vagrant/grokit/src

    # Compile datapath
    ./compile.datapath.sh

    log "${FUNCNAME[0]}: Grokit datapath successfully setup"
    
    # Configure disk
    cd /home/vagrant/grokit/src/Tool_DataPath/executable
    touch /home/vagrant/grokit/disk

    # Prevent vagrant stopping
    echo "0
1
1" > QUAN
    
    sh -c "./dp -be QUAN | true" 

    # Install grokit
    cd /home/vagrant/grokit/src
    PREFIX=/usr make install

    # Install grokit 'base' library
    grokit makelib /home/vagrant/grokit/Libs/base

    # Temp fix to Install gtBase on grokit system
    sudo sh -c "echo '{}' > ~/schema.json"
    sudo sh -c "echo '{}' > /home/vagrant/schema.json"
    sudo sh -c "echo 'export mode=\"offline\"' > /etc/environment"
    export mode='offline'

    # Mkdir Q1
    mkdir /Q1 | true

    # Set necessary file permissions
    chmod 777 /home/vagrant/grokit/src/Tool_DataPath/executable/ -R
    chmod 777 /home/vagrant/schema.json
    chmod 777 /Q1 -R
    # Return to home
    cd /home/vagrant/  
}

# Install gtbase R files
function install_R_base() {

    # Install R-dependencies
    Rscript -e "install.packages('rjson', repos='http://cran.us.r-project.org')"
    Rscript -e "install.packages('RSQLite', repos = 'http://cran.us.r-project.org')"
    Rscript -e "install.packages('RUnit', repos = 'http://cran.us.r-project.org')"
    # Checkout offline branch ## WARNING: Offline branch breaks 'gtSampling'
    # cd /home/vagrant/gtBase
    # git checkout add-offline-support
    # cd /home/vagrant

    # Build RJson
    #Rscript build_json.R

    # Go to gtbase 
    log "Running ${FUNCNAME[0]}"

    R CMD INSTALL gtBase

    log "${FUNCNAME[0]}: gtBase successfully installed"
    
}

# Install grokit statistic library
function install_statistics() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Installing Grokit 'Statistics' library"

    grokit makelib statistics

    log "${FUNCNAME[0]}: 'Statistics' library successfully installed"

}

# Install grokit gtLearning library
function install_gtLearning() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Installing Grokit 'gtLearning' library"

    grokit makelib gtLearning/package/inst/learning/
    R CMD INSTALL gtLearning/package/

    log "${FUNCNAME[0]}: 'gtLearning' library successfully installed"

}


# Install grokit gtJson library
function install_gtJson() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Installing Grokit 'gtJson' library"

    R CMD INSTALL gtJson

    log "${FUNCNAME[0]}: 'gtJson' library successfully installed"

}


# Install grokit gtSampling library
function install_gtStats() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Installing Grokit 'gtStats' library"

    grokit makelib statistics/
    R CMD INSTALL gtStats

    log "${FUNCNAME[0]}: 'gtStats' library successfully installed"

}


# Install grokit gtSampling library
function install_gtSampling() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Installing Grokit 'gtSampling' library"

    R CMD INSTALL gtSampling

    log "${FUNCNAME[0]}: 'gtSampling' library successfully installed"

}

# Install grokit gtTranslator library
function install_gtTranslator() {

    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Installing Grokit 'gtTranslator' library"

    grokit makelib translator/
    R CMD INSTALL gtTranslator

    log "${FUNCNAME[0]}: 'gtTranslator' library successfully installed"

}

# Run Grokit Build tests
function run_build_tests() {
    
    log "Running ${FUNCNAME[0]}"

    log "${FUNCNAME[0]}: Running Grokit build tests"

    # Copy file to working directory
    cp /vagrant/GrokitBuildTest.R ~/GrokitBuildTest.R

    # Test GroupBy
    printf '0\n1\n1' | mode=offline Rscript GrokitBuildTest.R

    log "${FUNCNAME[0]}: Finished runnig build tests"
}