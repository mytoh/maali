#!/bin/sh

set -e

build_gauche() {
    SOURCE=Gauche.tgz
    wget -O $SOURCE http://practical-scheme.net/gauche/latest
    tar xzvf $SOURCE
    VERSION=`curl -s http://practical-scheme.net/gauche/latest/version`
    SOURCE_DIR="Gauche-${VERSION}"
    (cd $SOURCE_DIR; ./configure; make; sudo make install)
}

run_test() {
    gosh -r7 -I. test.scm
}

build_gauche
run_test
