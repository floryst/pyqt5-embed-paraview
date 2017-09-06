#include "pvwidget.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    PVWidget w;
    w.show();

    return a.exec();
}
