#!/bin/sh

set -e

build_gauche_release() {
    SOURCE=Gauche.tgz
    wget -O $SOURCE http://practical-scheme.net/gauche/latest
    tar xzf $SOURCE
    VERSION=`curl -s http://practical-scheme.net/gauche/latest/version`
    SOURCE_DIR="Gauche-${VERSION}"
    (cd $SOURCE_DIR; ./configure; make; sudo make install)
}

build_gauche_release() {
    SOURCE_DIR="gauche-head"
    git clone git://github.com/shirok/gauche ${SOURCE_DIR}
    (cd $SOURCE_DIR; ./DIST gen; ./configure --prefix=test ; make; sudo make install)
}

run_test() {
    test/bin/gosh -r7 -I. test.scm
}

build_gauche_release
build_gauche_head
run_test
