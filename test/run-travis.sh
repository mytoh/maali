#!/bin/sh

set -e

TEST_PREFIX=/home/travis/build/test

build_gauche_release() {
    SOURCE=Gauche.tgz
    wget -O $SOURCE http://practical-scheme.net/gauche/latest
    tar xzf $SOURCE
    VERSION=`curl -s http://practical-scheme.net/gauche/latest/version`
    SOURCE_DIR="Gauche-${VERSION}"
    (cd $SOURCE_DIR; ./configure; make --quiet ; sudo make --quiet install)
}

build_gauche_head() {
    SOURCE_DIR="gauche-head"
    git clone git://github.com/shirok/gauche ${SOURCE_DIR}
    (cd $SOURCE_DIR; ./DIST gen; ./configure --prefix=${TEST_PREFIX} ; make --quiet ; sudo make --quiet install)
}

run_test() {
    ${TEST_PREFIX}/bin/gosh -r7 -I. ./test/test.scm
}

build_gauche_release
build_gauche_head
run_test
