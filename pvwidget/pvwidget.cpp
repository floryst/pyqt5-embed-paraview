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

#include "pvwidget.h"
#include "ui_pvwidget.h"

#include <clocale>

// We need to override the default options to enable streaming by default.
// Streaming needs to be enabled for the dax representations
class PVWidgetOptions : public pqOptions
{
public:
  static PVWidgetOptions* New();
  vtkTypeMacro(PVWidgetOptions, pqOptions) int GetEnableStreaming() override
  {
    return 1;
  }

protected:
  PVWidgetOptions() : pqOptions() { ; }
};
vtkStandardNewMacro(PVWidgetOptions)

PVWidget::PVWidget(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::PVWidget)
{
    int argc = 1;
    char arg0[] = "pvwidget";
    char* argv[] = { &arg0[0], NULL };

    setlocale(LC_NUMERIC, "C");
    vtkNew<PVWidgetOptions> options;
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

PVWidget::~PVWidget()
{
    delete ui;
    delete pvAppCore;
}

int PVWidget::squared(int x)
{
  return x * x;
}
