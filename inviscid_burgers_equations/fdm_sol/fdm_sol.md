## Problem Formulation

The inviscid Burger's equation with Dirichlet boundary conditions is given by:
$$
\frac{\partial u}{\partial t} + u \frac{\partial u}{\partial x} = 0  
$$
where $u(x,t)$ is the velocity of the fluid at position $x$ and time $t$. The Dirichlet boundary conditions are given by:
$$
u(0, t) = u(L, t) = 0
$$
where $L$ is the length of the domain.

The initial condition for this problem is given by:
$$
u(x, 0) = f(x)
$$
where $f(x)$ is a given function.

We will solve this problem using the finite difference method.

## Method Description

We will use the central difference scheme for both time and space discretization. The discretized form of the equation is given by:
$$
\frac{u_i^{n+1} - u_i^{n-1}}{2 \Delta t} + u_i^{n}\frac{u_{i+1}^{n} - u_{i-1}^{n}}{2 \Delta x} = 0
$$
where $u_i^n$ denotes the value of $u$ at position $x_i$ and time $t_n$, and $\Delta x$ and $\Delta t$ are the grid spacings in space and time, respectively.

Rearranging the above equation, we get:
$$
u_{i}^{n+1} = u_{i}^{n-1} - \frac{\Delta t}{\Delta x} u_{i}^{n} (u_{i+1}^n - u_{i-1}^n)
$$
The boundary conditions can be enforced by setting $u_1^n = u_N^n = 0$ for all $n$.

We will solve the above equation using MATLAB. The code will be organized into the following modules:

1. Initialization module: This module will initialize the parameters, such as the length of the domain, the number of grid points, the time step, and the initial condition.
2. Boundary condition module: This module will enforce the boundary conditions.
3. Time integration module: This module will integrate the equation in time using the central difference scheme.
4. Plotting module: This module will plot the results.

## MATLAB Code

