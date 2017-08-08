%Module MyWindowMod

%Import QtWidgets/QtWidgetsmod.sip

class MyWindow : public QMainWindow
{

%TypeHeaderCode
#include "foo.h"
%End

public:
  MyWindow(QWidget* parent /TransferThis/ = 0);
  ~MyWindow();

  int squared(int x);
};
