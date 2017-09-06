#ifndef _PVWIDGET_H
#define _PVWIDGET_H

#include <QtCore>
#include <QMainWindow>

namespace Ui {
class PVWidget;
}

class pqPVApplicationCore;

class PVWidget : public QMainWindow
{
  Q_OBJECT

public:
    explicit PVWidget(QWidget* parent = 0);
    ~PVWidget();

    int squared(int x);

private:
    Ui::PVWidget *ui;

    pqPVApplicationCore* pvAppCore;
};
#endif
