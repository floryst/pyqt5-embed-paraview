import sys
import signal
signal.signal(signal.SIGINT, signal.SIG_DFL)

from PyQt5.QtWidgets import *
from PyQt5.QtCore import *

import pvpy

class Demo(QWidget):
    def __init__(self, *args, **kwargs):
        super(Demo, self).__init__(*args, **kwargs)

        self.setWindowTitle("Demo")
        self.resize(1024, 768)

        self.layout = QVBoxLayout()

        self.pvwidget = pvpy.PVWidget()
        self.pvwidget.setWindowFlags(Qt.Widget)
        self.layout.addWidget(self.pvwidget)

        self.setLayout(self.layout)

if __name__ == '__main__':
    
    app = QApplication(sys.argv)

    window = Demo()
    window.show()
    
    sys.exit(app.exec_())
