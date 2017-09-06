#ifndef _FOO_H
#define _FOO_H

#include <QtCore>
#include <QMainWindow>

namespace Ui {
class MyWindow;
}

class pqPVApplicationCore;

class MyWindow : public QMainWindow
{
  Q_OBJECT

public:
    explicit MyWindow(QWidget* parent = 0);
    ~MyWindow();

    int squared(int x);

private:
    Ui::MyWindow *ui;

    pqPVApplicationCore* pvAppCore;
};
#endif
