mkdir -p build/ && cd build/

QTPREFIX=/opt/Qt5.9.0/5.9.1/gcc_64/
PARAVIEW_ROOT=$HOME/ParaView/build-qt5.9.1

# include qt modules
export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:$QTPREFIX/lib/cmake/
export PATH=$QTPREFIX/bin/:${PATH}
export LD_LIBRARY_PATH=$QTPREFIX/lib/:${LD_LIBRARY_PATH}

# include paraview
export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:$PARAVIEW_ROOT/lib/cmake/
export PATH=$PARAVIEW_ROOT/bin:${PATH}
export LD_LIBRARY_PATH=$PARAVIEW_ROOT/lib/:${LD_LIBRARY_PATH}

echo $CMAKE_PREFIX_PATH

cmake \
  -DQT5_DIR=$QTPREFIX \
  -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so \
  -DPYTHON_INCLUDE_DIR=/usr/include/python2.7 \
  ..

make -j8
