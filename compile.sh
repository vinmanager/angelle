#!/bin/bash
PROJECT_ROOT=$(pwd)
BUILD_DIR=Debug
echo "PROJECT_ROOT: ${PROJECT_ROOT}"

if [ ! -d "${BUILD_DIR}" ]; then
    mkdir ${BUILD_DIR}
fi
if [ ! -d "${PROJECT_ROOT}/release" ]; then
    mkdir ${PROJECT_ROOT}/release
fi

RELEASE_PATH=${PROJECT_ROOT}/release

# git submodule update --init
# git submodule update --remote

pushd ${BUILD_DIR}

cmake -DCMAKE_INSTALL_PREFIX=${RELEASE_PATH} ..
make -j8
make install

popd

rm -rf ${BUILD_DIR}

export LD_LIBRARY_PATH=${PROJECT_ROOT}/3rdparty/gtest/libs:$LD_LIBRARY_PATH
