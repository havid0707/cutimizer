The Two-dimensional Cutting Stock (2CS) problem is defined as follows. Given an unlimited quantity of
two-dimensional bins B = (W, H) of width W and height H, and a list of m items (small rectangles) each item
i with dimensions (wi, hi) and demand di (i = 1,. . . ,m), determine how to cut the smallest number of bins B so
as to produce di units of each item i. Such an instance for the 2CS problem is denoted by I = (W, H, w, h, d).
Following the typology of Wäscher et al., this is the Two-dimensional Rectangular Single
Stock Size Cutting Stock Problem.

This software solves the modified version in which one has bins and items of differents depth, however items of a given depth can only be cut out of bins with the same depth. Hence, it becomes many 2CS problems that can be solved independently.

The solution strategy uses the column generation approach, first proposed by Gilmore and Gomory in "A linear programming approach to the cutting stock program". It implies the following 4 steps:

1)Model the problem as a set covering.
2)Solve the linear programming relaxation of the set covering using any LP optimizer.
3)Use dynamic programming algorithms to generate relevant cutting patterns.
4)Solve the integer programming of the set covering with the generated cutting patterns thou the Branch and Bound routine in any LP optimizer.

The program has three optimizer available for use: lpsolve, glpk and gurobi. The first two are free open sourced and the last one provides free academic and trial licenses.

