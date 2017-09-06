#!/bin/bash
set -e

## Change these variables
# path to Qt root
QT_ROOT=/opt/Qt5.8.0/5.8/gcc_64/
# path to paraview
PARAVIEW_ROOT=$HOME/ParaView/build-qt5.8.0
# path to sip binary
SIP=sip
# path to sip's root directory
SIP_ROOT=$HOME/pyqt5.8env/

## Don't change these variables!
ROOT_DIR=$(dirname "$(readlink -f "$0")")
BUILD_DIR=$ROOT_DIR/build
DIST_DIR=$ROOT_DIR/dist

mcd() {
  mkdir -p "$1" && cd "$1"
}

mcd $BUILD_DIR

## build pvwidget
mcd $BUILD_DIR/libpvwidget

# include qt modules
export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:$QT_ROOT/lib/cmake/
export PATH=$QT_ROOT/bin:${PATH}
export LD_LIBRARY_PATH=$QT_ROOT/lib/:${LD_LIBRARY_PATH}

# include paraview
export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:$PARAVIEW_ROOT/lib/cmake/
export PATH=$PARAVIEW_ROOT/bin:${PATH}

cmake \
  -DQT5_DIR=$QT_ROOT \
  -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so \
  -DPYTHON_INCLUDE_DIR=/usr/include/python2.7 \
  $ROOT_DIR/pvwidget

make

## build pvpy
mcd $BUILD_DIR/pvpy

sipopts=$(python -c "from PyQt5 import QtCore; print(QtCore.PYQT_CONFIGURATION['sip_flags'])")
$SIP -c $BUILD_DIR/pvpy -b pvpy.sbf -I $SIP_ROOT/share/sip/PyQt5 $sipopts $ROOT_DIR/pvpy/pvpy.sip

cp $ROOT_DIR/pvpy/Makefile $BUILD_DIR/pvpy

libpvwidget_libdir=$BUILD_DIR/libpvwidget
includes="-I$SIP_ROOT/include/python2.7 -I$ROOT_DIR/pvwidget"
make PVWIDGET_LIBDIR="$libpvwidget_libdir" QT_ROOT="$QT_ROOT" CPP_INCLUDES="$includes"

## copy to dist
mcd $DIST_DIR
cp $BUILD_DIR/libpvwidget/libpvwidget.so $DIST_DIR
cp $BUILD_DIR/pvpy/pvpy.so $DIST_DIR
