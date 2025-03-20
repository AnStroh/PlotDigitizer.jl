#Testing-----------------------------------------------------------------------
@testset "Check coefficients" begin
    T  = LinRange(1273.0,1873.0,100)                                        #Choose the temperature range of the phase diagram
    coeff_do_comp = [9.79427908555563;
                -0.010021212961038951;
                2.6061746209320835e-6]
    coeff_up_comp = [9.79427908555563;
                -0.010021212961038951;
                2.6061746209320835e-6]
    y_comp  = coeff_do_comp[1] .+ coeff_do_comp[2] .* T .+ coeff_do_comp[3] * T .^ 2.0
    y2_comp = coeff_up_comp[1] .+ coeff_up_comp[2] .* T .+ coeff_up_comp[3] * T .^ 2.0
    #@test y ≈ y_comp = 1e-4
end