import sys
import signal
signal.signal(signal.SIGINT, signal.SIG_DFL)

from PyQt5.QtWidgets import *
from PyQt5.QtCore import *

# Import ParaView widget
import pvpy

import vtk
from paraview import simple as pv

DEMO_FILE = 'Branch.n010.mha'

class Demo(QWidget):
    def __init__(self, *args, **kwargs):
        super(Demo, self).__init__(*args, **kwargs)

        self.setWindowTitle("Demo")
        self.resize(1024, 768)

        # Creates and sets the layout for the main window
        self.layout = QVBoxLayout()
        self.setLayout(self.layout)

        # Create and add the ParaView widget
        self.pvwidget = pvpy.PVWidget()
        self.pvwidget.setWindowFlags(Qt.Widget)
        self.layout.addWidget(self.pvwidget)

        # Add UI stuff
        self.layout.addWidget(QLabel("<h2>Awesome UI here</h2>"))
        button = QPushButton("Load demo data")
        self.layout.addWidget(button)
        self.layout.addWidget(QPushButton("Dummy button 2"))

        # Load data on clicking the demo data button
        button.clicked.connect(self.loadDemoData)

        # Create an orthographic slice viewer
        pv.RemoveViewsAndLayouts()
        self.view = pv.CreateView('OrthographicSliceView')

    @pyqtSlot()
    def loadDemoData(self):
        # Read in sample file
        reader = vtk.vtkImageReader2Factory.CreateImageReader2(DEMO_FILE)
        reader.SetFileName(DEMO_FILE)
        reader.Update()
        imageData = reader.GetOutput()

        # Display image
        proxy = pv.TrivialProducer()
        tp = proxy.GetClientSideObject()
        tp.SetOutput(imageData)
        proxy.UpdateVTKObjects()

        pv.Show(proxy)
        pv.Render()

if __name__ == '__main__':
    
    app = QApplication(sys.argv)

    window = Demo()
    window.show()
    
    sys.exit(app.exec_())
