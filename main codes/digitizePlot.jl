using PlotDigitizer

file_name = "../Examples_phase_diagram/Ol_Phase_diagram_without_framework.png"
X_BC       = (0.0,   1.0)   #min max of X in the phase diagram
Y_BC       = (0.0, 350.0)   #min max of Y in the phase diagram
lines      = digitizePlot(X_BC, Y_BC, file_name)