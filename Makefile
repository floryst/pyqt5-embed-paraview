TARGET = MyWindowMod.so
OFILES = sipMyWindowModcmodule.o sipMyWindowModMyWindow.o
HFILES = sipAPIMyWindowMod.h 

CC = gcc
CXX = g++
LINK = g++
CPPFLAGS = -DNDEBUG -DQT_NO_DEBUG -DQT_CORE_LIB -DQT_GUI_LIB -I. -I/home/forrestli/pyqt5env/include/python2.7 -I/usr/include/python2.7 -I/opt/Qt5.9.0/5.9.1/gcc_64/mkspecs/default -I/opt/Qt5.9.0/5.9.1/gcc_64/include/QtCore -I/opt/Qt5.9.0/5.9.1/gcc_64/include/QtGui -I/opt/Qt5.9.0/5.9.1/gcc_64/include -I/usr/X11R6/include -I/opt/Qt5.9.0/5.9.1/gcc_64/include/QtWidgets
CFLAGS = -m64 -pipe -fPIC -O2 -Wall -W -D_REENTRANT
CXXFLAGS = -m64 -pipe -fPIC -O2 -Wall -W -D_REENTRANT -std=c++11
LFLAGS = -shared  -Wl,-O1 -Wl,-rpath,/usr/lib/x86_64-linux-gnu -Wl,--version-script=MyWindowMod.exp -L/home/forrestli/pyqt5env/libfoo/build
LIBS = -L/opt/Qt5.9.0/5.9.1/gcc_64/lib -L/usr/lib/x86_64-linux-gnu -L/usr/X11R6/lib64 -lfoo -lQt5Core -lQt5Gui -lXext -lX11 -lm -lpthread
MOC = /opt/Qt5.9.0/5.9.1/gcc_64/bin/moc
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
	@echo '{ global: initMyWindowMod; local: *; };' > MyWindowMod.exp
	$(LINK) $(LFLAGS) -o $(TARGET) $(OFILES) $(LIBS)

clean:
	-rm -f $(TARGET)
	-rm -f sipMyWindowModcmodule.o
	-rm -f sipMyWindowModMyWindow.o
	-rm -f MyWindowMod.exp
