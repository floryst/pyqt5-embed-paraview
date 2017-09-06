# PyQt5 with Embedded ParaView

This project provides an embedded paraview Qt widget for PyQt5.

## Setup/Building

These instructions were performed on an Ubuntu 16.04-2 install. Currently,
Windows and macOS is not supported due to lack of testing and the need to ensure
cross-platform interoperability with the build process.

The components of the build process is outlined below.

- Qt5
- ParaView
- Virtualenv setup
- SIP
- PyQt5
- pyqt5-embed-paraview

### Package prerequisites

On Ubuntu, install the following packages:

- `python-dev`

### Qt5

You will need to have an installation of Qt5. We recommend downloading a
prebuilt Qt from the official website. However, you may opt to use
system-provided Qt libraries (untested).

For the rest of the document, Qt 5.8.0 will be used.

If you want to download Qt5 prebuilts, go to the
[Qt official archives](https://download.qt.io/archive/qt/) and download a
desired Qt package. We recommend downloading Qt 5.8.0 to match the Qt version of
current ParaView stable.

Once downloaded, run and install. For the rest of this document, Qt is assumed
to be installed at `/home/kwuser/Qt/`.

### ParaView

It is recommended that you use the ParaView superbuild, found here:
<https://gitlab.kitware.com/paraview/paraview-superbuild>
If you use the superbuild, be sure to enable Qt and Python.

Required Ubuntu packages if you don't build the superbuild.
- `python-dev`
- `libtbb2`
- `libtbb-dev`
- `libglu1-mesa-dev`
- `libxt-dev`

Get Paraview from the [Github repository](https://github.com/kitware/paraview).
```
git clone --recursive https://github.com/Kitware/ParaView.git
```

Build paraview against downloaded Qt and Python 2.7 as follows:
```
QT_ROOT=/home/kwuser/Qt
export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:$QT_ROOT/lib/cmake/
export PATH=$QT_ROOT/bin/:${PATH}
export LD_LIBRARY_PATH=$QT_ROOT/lib/:${LD_LIBRARY_PATH}

mkdir paraview-build && cd paraview-build

cmake \
    -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so \
    -DPYTHON_EXECUTABLE=/usr/bin/python2.7 \
    -DPYTHON_INCLUDE_DIR=/usr/include/python2.7 \
    -DPARAVIEW_ENABLE_PYTHON:BOOL=ON \
    -DPARAVIEW_QT_VERSION:STRING=5 \
    -DVTK_RENDERING_BACKEND:STRING=OpenGL2 \
    -DVTK_SMP_IMPLEMENTATION_TYPE:STRING=TBB \
    -DVTK_PYTHON_VERSION:STRING=2 \
    -DVTK_PYTHON_FULL_THREADSAFE:BOOL=ON \
    -DVTK_NO_PYTHON_THREADS:BOOL=OFF \
    /path/to/ParaView/

cmake --build .
```

### Virtualenv

Setup a Python virtual environment to provide an isolated Python 2.7 install.
While not strictly necessary, it's useful for python environment isolation, even
if it means extra work to explicitly supply include/library paths.

```
$ sudo apt install virtualenv
$ virtualenv --always-copy /home/kwuser/pyqt5env
$ source /home/kwuser/pyqt5env/bin/activate
```

From here on out, the existence of the virtualenv will be denoted as a prefix on
the shell prompt:

```
(pyqt5env) $
```

### SIP

If you are targeting Python 3, you may install SIP via `pip install sip`.
If you are targeting Python 2, you will need to follow the instructions for
building SIP.

Download SIP
[from this link](https://www.riverbankcomputing.com/software/sip/download),
extract it, then enter the newly created directory. The following commands will
build and install SIP.

```
(pyqt5env) $ cd sip-4.19.3/
(pyqt5env) $ python configure.py
(pyqt5env) $ make install
```
Building (single core) should take, at maximum, half a minute.

### PyQt5

If you are targeting Python 3, you may install PyQt5 via `pip install PyQt5`.
If you are targeting Python 2, you will need to follow the instructions for
building PyQt5.

Download PyQt5
[from this link](https://www.riverbankcomputing.com/software/pyqt/download5),
extract it, then enter the newly created directory. The following commands will
build and install PyQt5.

```
(pyqt5env) $ cd PyQt5_gpl-5.9/
(pyqt5env) $ python configure.py -q /home/kwuser/Qt/5.8/gcc_64/bin/qmake --sip-incdir=/home/kwuser/pyqt5env/include/python2.7
(pyqt5env) $ make install
```

Building (single core) should take no more than 10 minutes.

### pyqt5-embed-paraview

First clone this repository.
To build, you will need to edit `build.sh` and supply the requested variables
as outlined near the top of the script.

Afterwards, run the script.

```
(pyqt5env) $ ./build.sh
```

This will copy `libpvwidget.so` and `pvpy.so` to `dist/`.

## Running the demo.py

First edit the `run.sh` and modify the `libpaths` and `pythonpaths` lists as
necessary. After supplying the proper paths, you should be able to run the demo
application as such:

```
(pyqt5env) $ ./run.sh demo.py
```
