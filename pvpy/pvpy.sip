%Module pvpy

%Import QtWidgets/QtWidgetsmod.sip

class PVWidget : public QMainWindow
{

%TypeHeaderCode
#include "pvwidget.h"
%End

public:
  PVWidget(QWidget* parent /TransferThis/ = 0);
  ~PVWidget();

  int squared(int x);
};
