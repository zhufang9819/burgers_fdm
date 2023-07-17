## 1. Steady viscous Burger's equation

The conservative form of the equation is:
$$
\frac{1}{2}  \frac{d(u^2)}{dx} - \nu * u \frac{d^2u}{dx^2} = 0
$$
and this is the version we discretize. 

If we use the ***central difference*** scheme on the term $d(u^2)/dx$, then the residual associated with node $i \in \{ 0, 1, 2, 3, 4, \cdots, n-1 \}$is then
$$
f(i) = \frac{1}{2} \frac{ u(i+1)^2 - u(i-1)^2} {  2  dx } - \nu * \frac{ u(i-1) - 2 * u(i) + u(i+1) } { dx^2}
$$


If we use the ***upwind*** scheme, then the formulation of the residual function $f$ is changed. If $u(i) >= 0 (i = 1, 2, \cdots, n-2)$, then 
$$
f(i) =   \frac{1}{2} \frac{ u(i)^2 - u(i-1)^2} { dx } -\nu * \frac{u(i+1) - 2*u(i) + u(i-1)}{dx^2}
$$
otherwise
$$
f(i) =  \frac{1}{2} \frac{ u(i+1)^2 - u(i)^2}{dx}-\nu * \frac{u(i+1) - 2*u(i) + u(i-1)}{dx^2}
$$
Comments:

The reason for this choice in the upwind scheme has to do with how information or "changes" propagate in a system described by a PDE, such as the Burgers' equation.

Let's consider a fluid flow as an example:

- If the flow velocity at a point ($u_i$) is positive, it means the fluid at that point is moving to the right. Therefore, any changes or "information" in the flow (like a sudden increase in velocity or density) will also propagate to the right. In other words, the status at a given point ($u_i$) in the near future will be affected by the status at points to its left (i.e., $u_{i-1}$), as changes move from left to right. That's why we use the backward difference scheme: ($\frac{u_i - u_{i-1}}{\Delta x}$) when $u_i$ is positive.
- Similarly, if the flow velocity at a point ($u_i$) is negative, it means the fluid at that point is moving to the left. Hence, any changes or "information" in the flow will propagate to the left. The status at a given point ($u_i$) in the near future will be influenced by the status at points to its right (i.e., $u_{i+1}$), as changes move from right to left. That's why we use the forward difference scheme: ($\frac{u_{i+1} - u_i}{\Delta x}$) when $u_i$ is negative.

So the reason for this choice in upwind schemes is to ensure that our numerical approximation correctly models the direction of propagation of changes or "information" in the system. In the context of PDEs, this choice often leads to more stable and accurate numerical solutions, especially for hyperbolic PDEs (which describe wave propagation and advection phenomena) and when the solution has steep gradients or discontinuities.

## 2. Time dependent viscous Burger's equation

The typical form of the equation is written:
$$
\frac{du}{dt} + u \frac{du}{dx} = \nu * \frac{d^2u}{dx^2}
$$


The conservative form of the equation is written:
$$
\frac{du}{dt} + \frac{1}{2}  \frac{d(u^2)}{dx} = \nu * \frac{d^2u}{dx^2}
$$


The space interval is taken to be $-1.0 \leq x \leq +1.0$. The time interval is taken to be $0 \leq t \leq t_{max}$.
