# GrokitDev Dependencies

The following details specify dependencies and required versions which resulted in a successful build of the Grokit engine.

## Operating System

Name: CentOS Linux 7 (Core)

Version #: 7.3.1611 (Core)

Vagrant Box: centos/7

## Major Dependencies

The following are highly version specific (specifically websocketpp) and are recommended to be installed from the links attached.

* **LEMON Graph Library**
  * Version: 1.2.3
  * Source: http://lemon.cs.elte.hu/pub/sources/lemon-1.2.3.tar.gz
* **ANTLR 3 Parser Generator**
  * Version: 3.4
  * Source: https://github.com/antlr/website-antlr3/raw/gh-pages/download/antlr-3.4-complete.jar
* **ANTLR 3 C Runtime**
  * Version: 3.0.1
  * Source: https://github.com/antlr/antlr3/tree/master/runtime/C
* **Oniguruma** *(Not necessary on RPM-based systems, see below)*
  * Version: 1.0(?)
  * Source: https://github.com/LuaDist/onig/
* **Astyle**
  * Version: 2.06
  * Source: https://sourceforge.net/projects/astyle
* **Websocketpp**
  * Version: **3.0.X** (branch called 'experimental')
  * Source: https://github.com/zaphoyd/websocketpp/tree/experimental
* **MCT**
  * Version: **1.6.2**
  * Source: https://code.launchpad.net/libmct
  
## Grokit Dependencies

The following repositories are referenced in the bootstrap scripts.

* **Grokit:** https://github.com/tera-insights/grokit.git
* **gtBase:** https://github.com/tera-insights/gtBase.git
* **Statistics:** https://github.com/tera-insights/statistics.git
* **gtLearning:** https://github.com/tera-insights/gtLearning.git

## Minor Dependencies

The following are installable via **yum** or **dnf**. Most are likely not version-specific, but the details are documented here in case of future conflicts.

**By approximate order of installation:**

```
epel-release-7.9.noarch
dnf-0.6.4-2.el7.noarch
dnf-conf-0.6.4-2.el7.noarch
python-dnf-0.6.4-2.el7.noarch
git-1.8.3.1-6.el7_2.1.x86_64
subversion-1.7.14-10.el7.x86_64
bc-1.06.95-13.el7.x86_64
clang-3.4.2-8.el7.x86_64
java-1.8.0-openjdk-1.8.0.121-0.b13.el7_3.x86_64
wget-1.14-13.el7.x86_64
java-1.8.0-openjdk-headless-1.8.0.121-0.b13.el7_3.x86_64
javapackages-tools-3.4.1-11.el7.noarch
java-1.8.0-openjdk-devel-1.8.0.121-0.b13.el7_3.x86_64
php-cli-5.4.16-42.el7.x86_64
php-pear-1.9.4-21.el7.noarch
php-xml-5.4.16-42.el7.x86_64
php-process-5.4.16-42.el7.x86_64
php-pecl-xdebug-2.2.7-1.el7.x86_64
php-pdo-5.4.16-42.el7.x86_64
php-common-5.4.16-42.el7.x86_64
jsoncpp-devel-0.10.5-2.el7.x86_64
jsoncpp-0.10.5-2.el7.x86_64
sqlite-3.7.17-8.el7.x86_64
sqlite-devel-3.7.17-8.el7.x86_64
openssl-1.0.1e-60.el7.x86_64
openssl-devel-1.0.1e-60.el7.x86_64
openssl-libs-1.0.1e-60.el7.x86_64
oniguruma-devel-5.9.5-3.el7.x86_64
oniguruma-5.9.5-3.el7.x86_64
boost-context-1.53.0-26.el7.x86_64
boost-test-1.53.0-26.el7.x86_64
boost-system-1.53.0-26.el7.x86_64
boost-filesystem-1.53.0-26.el7.x86_64
boost-date-time-1.53.0-26.el7.x86_64
boost-program-options-1.53.0-26.el7.x86_64
boost-math-1.53.0-26.el7.x86_64
boost-serialization-1.53.0-26.el7.x86_64
boost-chrono-1.53.0-26.el7.x86_64
boost-regex-1.53.0-26.el7.x86_64
boost-graph-1.53.0-26.el7.x86_64
boost-iostreams-1.53.0-26.el7.x86_64
boost-random-1.53.0-26.el7.x86_64
boost-1.53.0-26.el7.x86_64
boost-timer-1.53.0-26.el7.x86_64
boost-python-1.53.0-26.el7.x86_64
boost-locale-1.53.0-26.el7.x86_64
boost-atomic-1.53.0-26.el7.x86_64
boost-signals-1.53.0-26.el7.x86_64
boost-devel-1.53.0-26.el7.x86_64
boost-thread-1.53.0-26.el7.x86_64
boost-wave-1.53.0-26.el7.x86_64
R-3.3.2-3.el7.x86_64
libRmath-3.3.2-3.el7.x86_64
R-core-devel-3.3.2-3.el7.x86_64
R-java-3.3.2-3.el7.x86_64
R-java-devel-3.3.2-3.el7.x86_64
libRmath-devel-3.3.2-3.el7.x86_64
openblas-Rblas-0.2.19-4.el7.x86_64
R-devel-3.3.2-3.el7.x86_64
R-core-3.3.2-3.el7.x86_64
armadillo-devel-4.320.0-1.el7.x86_64
armadillo-4.320.0-1.el7.x86_64
emacs-filesystem-24.3-18.el7.noarch
emacs-common-24.3-18.el7.x86_64
emacs-24.3-18.el7.x86_64
htop-2.0.2-1.el7.x86_64
libstdc++-4.8.5-11.el7.i686
libstdc++-4.8.5-11.el7.x86_64
libstdc++-devel-4.8.5-11.el7.x86_64
autoconf-2.69-11.el7.noarch
automake-1.13.4-3.el7.noarch
libtool-ltdl-2.4.2-21.el7_2.x86_64
bison-2.7-4.el7.x86_64
flex-2.5.37-3.el7.x86_64
libtool-2.4.2-21.el7_2.x86_64
ncurses-base-5.9-13.20130511.el7.noarch
ncurses-libs-5.9-13.20130511.el7.x86_64
ncurses-5.9-13.20130511.el7.x86_64
ncurses-libs-5.9-13.20130511.el7.i686
glibc-headers-2.17-157.el7_3.1.x86_64
glibc-2.17-157.el7_3.1.x86_64
glibc-common-2.17-157.el7_3.1.x86_64
glibc-devel-2.17-157.el7_3.1.x86_64
glibc-2.17-157.el7_3.1.i686
bzr-2.5.1-14.el7.x86_64
gperftools-libs-2.4-8.el7.x86_64
gperftools-devel-2.4-8.el7.x86_64
```

For easy installation of minor dependencies the following script has been attached.

```bash
 yum install -y epel-release \
    dnf \
    git \
    svn \
    autoconf \
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
```
