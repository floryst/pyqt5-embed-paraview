#!/bin/bash

ROOT_DIR=$(dirname "$(readlink -f "$0")")

# Modify these variables as needed
QT_ROOT=/opt/Qt5.8.0/5.8/gcc_64

libpaths=(
  $ROOT_DIR/dist

  # path to Qt libraries
  $QT_ROOT/lib

  ## If using a custom compiled paraview, uncomment and edit these lines
  /path/to/paraview-build/lib
)
pythonpaths=(
  $ROOT_DIR/dist

  ## If using a custom compiled paraview, uncomment and edit these lines
  /path/to/paraview-build/lib
  /path/to/paraview-build/lib/site-packages
)

printf -v libpaths ":%s" "${libpaths[@]}"
printf -v pythonpaths ":%s" "${pythonpaths[@]}"

export LD_LIBRARY_PATH="${libpaths:1}":${LD_LIBRARY_PATH}
export PYTHONPATH="${pythonpaths:1}":${PYTHONPATH}

python $@
