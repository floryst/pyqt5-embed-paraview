#include <pqOptions.h>
#include <pqPVApplicationCore.h>

#include <pqAlwaysConnectedBehavior.h>
#include <pqDefaultViewBehavior.h>
#include <pqPersistentMainWindowStateBehavior.h>
#include <pqViewStreamingBehavior.h>
#include <pqApplicationCore.h>
#include <pqStandardViewFrameActionsImplementation.h>
#include <pqStandardPropertyWidgetInterface.h>
#include <pqInterfaceTracker.h>

#include <vtkNew.h>
#include <vtkObjectFactory.h>

#include "foo.h"
#include "ui_mywindow.h"

#include <clocale>

// We need to override the default options to enable streaming by default.
// Streaming needs to be enabled for the dax representations
class FooOptions : public pqOptions
{
public:
  static FooOptions* New();
  vtkTypeMacro(FooOptions, pqOptions) int GetEnableStreaming() override
  {
    return 1;
  }

protected:
  FooOptions() : pqOptions() { ; }
};
vtkStandardNewMacro(FooOptions)

MyWindow::MyWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MyWindow)
{
    int argc = 1;
    char arg0[] = "foo";
    char* argv[] = { &arg0[0], NULL };

    setlocale(LC_NUMERIC, "C");
    vtkNew<FooOptions> options;
    pvAppCore = new pqPVApplicationCore(argc, argv, options.Get());

    ui->setupUi(this);

    auto pgm = pvAppCore->interfaceTracker();
    pgm->addInterface(new pqStandardPropertyWidgetInterface(pgm));
    pgm->addInterface(new pqStandardViewFrameActionsImplementation(pgm));

    new pqDefaultViewBehavior(this);
    new pqAlwaysConnectedBehavior(this);
    new pqViewStreamingBehavior(this);
    new pqPersistentMainWindowStateBehavior(this);

    // this will trigger the logic to setup reader/writer factories, etc.
    pqApplicationCore::instance()->loadConfigurationXML("<xml/>");
}

MyWindow::~MyWindow()
{
    delete ui;
    delete pvAppCore;
}

int MyWindow::squared(int x)
{
  return x * x;
}
