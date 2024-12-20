# PlotDigitizer
This package is used to extract X, Y values from 2D plots.

# Installation

Clone this repo to your computer and open the julia REPL. Navigate to the DigitizePlot directory and activate the environment by typing

```julia
julia> ]
```
 
 to enter the julia package manager and then 

```julia
(@v1.10) pkg> activate .
```

to activate the environemt. Following type 

```julia
(PlotDigitizer) pkg> instantiate
```

to download and precompile the correct versions of the needed packages. 

# How to use PlotDigitizer

To digitize points from a 2D plot you need to call the ```digitizePlot()``` function which will open a new window. The needed input of this function are the boundary consitions of the X and Y axis, each as a ```Tuple``` as well as the path to the image to be digitized as a ```String```.

Once the window has opened, you are free to click in the window to add points to create a line. If you misclick, you can remove the last point by holding the ```d```key when clicking. 