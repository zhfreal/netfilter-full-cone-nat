#!/bin/sh
VER=0.1
BUILD_NAME=xt_FULLCONENAT
TARGET=/usr/src/$BUILD_NAME-$VER

if ! dkms status > /dev/null 2>&1; then
    apt update && apt install dkms
fi

if ! [ -d $TARGET ]; then
    mkdir $TARGET
    cp xt_FULLCONENAT.c \
    dkms.conf Makefile \
    LICENSE README.md \
    libipt_FULLCONENAT.c \
    libipt_FULLCONENAT.t \
    install-dkms.sh \
    $TARGET
fi


if ! dkms status -m $BUILD_NAME -v $VER > /dev/null 2>&1; then
    dkms add -m $BUILD_NAME -v $VER
elif ! dkms status -m $BUILD_NAME -v $VER -k $(uname -r) > /dev/null 2>&1; then
    dkms build -m $BUILD_NAME -v $VER
    dkms install -m $BUILD_NAME -v $VER
fi
