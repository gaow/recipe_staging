#!/bin/bash
export DISABLE_AUTOBREW=1
export PKG_CPPFLAGS="-DHAVE_WORKING_LOG1P"
$R CMD INSTALL --build .