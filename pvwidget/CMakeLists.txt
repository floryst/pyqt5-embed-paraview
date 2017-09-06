cmake_minimum_required(VERSION 2.6)

project(libfoo)

# Find includes in the build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Turn on automatic invocation of the MOC
set(CMAKE_AUTOMOC ON)

# There may be a way to tell up front if Qt5 is going to be found, but I haven't found
# a foolproof way to do it yet, so settle for the default error message for now.
#if(NOT CMAKE_PREFIX_PATH AND NOT Qt5Widgets_DIR)
#    message(WARNING "CMAKE_PREFIX_PATH is not defined, so find_package may not work. Set the CMAKE_PREFIX_PATH "
#            "environment variable to the install prefix of Qt 5, either on the command line as "
#            "-DCMAKE_PREFIX_PATH=\"path/to/Qt5/lib/cmake\" or with set(CMAKE_PREFIX_PATH path/to/Qt5/lib/cmake)")
#endif(NOT CMAKE_PREFIX_PATH AND NOT Qt5Widgets_DIR)

# Add a compiler flag
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")

# Make this a GUI application on Windows
if(WIN32)
  set(CMAKE_WIN32_EXECUTABLE ON)
endif()

# Find the QtWidgets library
find_package(Qt5Widgets REQUIRED)

# find paraview
find_package(ParaView REQUIRED)

# find opengl
find_package(OpenGL REQUIRED)

## PARAVIEW

if(NOT PARAVIEW_BUILD_QT_GUI)
  message(FATAL_ERROR
    "libfoo requires PARAVIEW_BUILD_QT_GUI to be enabled. "
    "Please rebuild ParaView with PARAVIEW_BUILD_QT_GUI set to TRUE.")
endif()
if(NOT PARAVIEW_ENABLE_PYTHON)
  message(FATAL_ERROR
    "libfoo requires PARAVIEW_ENABLE_PYTHON to be enabled. "
    "Please rebuild ParaView with PARAVIEW_ENABLE_PYTHON set to TRUE.")
endif()
if(NOT PARAVIEW_QT_VERSION STREQUAL "5")
  message(FATAL_ERROR
    "libfoo requires PARAVIEW_QT_VERSION to be 5, please rebuild ParaView.")
endif()

## END PARAVIEW

include_directories(SYSTEM
  ${Qt5Widgets_INCLUDE_DIRS}
  ${PARAVIEW_INCLUDE_DIRS})

# Generate code from ui files
qt5_wrap_ui(UI_HEADERS mywindow.ui)

# Generate rules for building source files from the resources
qt5_add_resources(QRCS resources.qrc)

# create the runner executable
add_executable(runner main.cpp foo.cpp ${UI_HEADERS} ${QRCS})

# library
add_library(libfoo SHARED foo.cpp ${UI_HEADERS} ${QSRCS})
set_target_properties(libfoo PROPERTIES PREFIX "")

# Add the libraries to link against libfoo
target_link_libraries(libfoo
  PUBLIC
    Qt5::Widgets
    ${OPENGL_LIBRARIES}
    pqApplicationComponents
    vtkPVServerManagerRendering
    vtkglew)

target_link_libraries(runner libfoo)
