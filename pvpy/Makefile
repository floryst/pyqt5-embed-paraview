TARGET = pvpy.so
OFILES = sippvpycmodule.o sippvpyPVWidget.o
HFILES = sipAPIpvpy.h

CC = gcc
CXX = g++
LINK = g++
CPPFLAGS = -DNDEBUG -DQT_NO_DEBUG -DQT_CORE_LIB -DQT_GUI_LIB -I. -I$(QT_ROOT)/mkspecs/default -I$(QT_ROOT)/include/QtCore -I$(QT_ROOT)/include/QtGui -I$(QT_ROOT)/include -I/usr/X11R6/include -I$(QT_ROOT)/include/QtWidgets $(CPP_INCLUDES)
CFLAGS = -m64 -pipe -fPIC -O2 -Wall -W -D_REENTRANT
CXXFLAGS = -m64 -pipe -fPIC -O2 -Wall -W -D_REENTRANT -std=c++11
LFLAGS = -shared  -Wl,-O1 -Wl,--version-script=pvpy.exp
LIBS = -L$(PVWIDGET_LIBDIR) -L$(QT_ROOT)/lib -L/usr/lib/x86_64-linux-gnu -L/usr/X11R6/lib64 -lpvwidget -lQt5Core -lQt5Gui -lXext -lX11 -lm -lpthread
MOC = $(QT_ROOT)/bin/moc
.SUFFIXES: .c .o .cpp .cc .cxx .C


.cpp.o:
	$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) -o $@ $<

.cc.o:
	$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) -o $@ $<

.cxx.o:
	$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) -o $@ $<

.C.o:
	$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) -o $@ $<

.c.o:
	$(CC) -c $(CFLAGS) $(CPPFLAGS) -o $@ $<

all: $(TARGET)

$(OFILES): $(HFILES)

$(TARGET): $(OFILES)
	@echo '{ global: initpvpy; local: *; };' > pvpy.exp
	$(LINK) $(LFLAGS) -o $(TARGET) $(OFILES) $(LIBS)

clean:
	-rm -f $(TARGET)
	-rm -f sippvpycmodule.o
	-rm -f sippvpyPVWidget.o
	-rm -f pvpy.exp
