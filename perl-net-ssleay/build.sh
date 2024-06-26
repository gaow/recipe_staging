#!/bin/bash

export OPENSSL_PREFIX=${PREFIX}

export PERL_MM_USE_DEFAULT=1

# Force use of conda's OpenSSL instead of the system one
if [ `uname -s` == "Darwin" ]; then
    export DYLD_FALLBACK_LIBRARY_PATH="${PREFIX}/lib"
else
    export LD_LIBRARY_PATH="${PREFIX}/lib"
fi

# Fix pollution from the perl build environment
export CFLAGS="-I/usr/include $CFLAGS"
dname=`find $PREFIX/lib -name Config_heavy.pl -print | xargs dirname`
sed -i.bak "s|^    cc => .*$|    cc => '${CC}',|" ${dname}/Config.pm
sed -i.bak "s|^ccflags=.*$|ccflags='${CFLAGS}'|;s|^ld=.*$|ld='${CC}'|;s|^cppflags=.*$|cppflags='${CFLAGS}'|;" ${dname}/Config_heavy.pl

# clean up
rm -f ${dname}/Config.pm.bak ${dname}/Config_heavy.pl.bak

# Make sure this goes in site
perl Makefile.PL INSTALLDIRS=vendor NO_PERLLOCAL=1 NO_PACKLIST=1
# Fix pollution from the perl build environment
sed -i.bak "s|^LDLOADLIBS = .*$|LDLOADLIBS = -L$PREFIX/lib -lssl -lcrypto -lz -lpthread|;s|/home/conda/feedstock_root/build_artifacts/perl_1550669032175/_build_env|$BUILD_PREFIX|g" Makefile
make
#make test
make install
