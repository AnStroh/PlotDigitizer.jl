using GLMakie, FileIO
GLMakie.activate!() # hide


"""
    calc_X_Y(point, X_BC, Y_BC, pixel)

Calculate the X and Y coordinates based on the given point, boundary conditions, and pixel information.

# Arguments
- `point::Tuple{Float64, Float64}`: The coordinates of the point to be transformed.
- `X_BC::Tuple{Float64, Float64}`: The boundary conditions for the X coordinate.
- `Y_BC::Tuple{Float64, Float64}`: The boundary conditions for the T coordinate.
- `pixel::Tuple{Int, Int}`: The pixel dimensions of the image.

# Returns
- `Tuple{Float64, Float64}`: The transformed X and Y coordinates.
"""
function calc_X_Y(point, X_BC, Y_BC, pixel)
    m_X = (X_BC[2]- X_BC[1])/pixel[1]
    m_Y = (Y_BC[2]- Y_BC[1])/pixel[2]

    X = linear_func(X_BC, point[1], m_X)
    Y = linear_func(Y_BC, point[2], m_Y) 
    
    return (X, Y)
end

"""
    linear_func(X, x, m)

Compute the linear function `Y = m * x + X[1]`.

# Arguments
- `X::Vector{T}`: A vector where `X[1]` is used as the y-intercept.
- `x::T`: The independent variable.
- `m::T`: The slope of the linear function.

# Returns
- `Y::T`: The computed value of the linear function.
"""
function linear_func(X, x, m)
    Y = m * x + X[1]
    return Y
end

function digitizePlot(X_BC::Tuple, Y_BC::Tuple, file_name::String)
    #Load image----------------------------------------------------
    img   = rotr90(load(assetpath(file_name)))
    pixel = size(img)
    #Create scene--------------------------------------------------
    scene       = Scene(camera = campixel!, size=pixel)
    image!(scene,img) 
    points      = Observable(Point2f[])
    points_conv = Observable([])
    #Get points----------------------------------------------------
    scatter!(scene, points, color = :red, marker = '+',markersize = 18)
    on(events(scene).mousebutton) do event
        if event.button == Mouse.left
            if event.action == Mouse.press || event.action == Mouse.release
                mp = events(scene).mouseposition[]
                pos = to_world(scene, mp)
                pos_conv = calc_X_Y(pos, X_BC, Y_BC, pixel)
                println("------------------------")
                println("Your new coordinate [x,y] within the picture is: $pos.")
                println("\n X, Y = $pos_conv \n")
                println("To exit the function, please close the window.")
                println("------------------------")
                push!(points[], mp)
                push!(points_conv[], pos_conv)
                notify(points)
                notify(points_conv)
            end
        end
        return points_conv
    end
    display(scene)

    return points_conv
end

file_name = "/home/annalena/Dropbox/Annalena_Vangelis_Diffusion_Couple/Julia_WORK_Annalena/examples/Examples_phase_diagram/Ol_Phase_diagram_without_framework.png"

Y_BC       = (1273.0, 1873.0)   #min max of Y in the phase diagram
X_BC       = (0.0, 1.0) 
coord = digitizePlot(X_BC, Y_BC, file_name)