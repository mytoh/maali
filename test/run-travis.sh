#!/bin/sh

set -e

TEST_PREFIX=/home/travis/build/test_prefix

run_test() {
    ${TEST_PREFIX}/bin/gosh -r7 -I${TRAVIS_BUILD_DIR}/lib ${TRAVIS_BUILD_DIR}/test/test.scm
}

build_gauche_release
build_gauche_head
run_test
