function U = burgers_time_inviscid ( method, ic_function, nx, nt, t_max, bc )

%*****************************************************************************80
%
%% burgers_time_inviscid() solves the time-dependent inviscid Burgers equation.
%
%  Discussion:
%
%    A number of solution methods are available for the user to choose.
%
%  Modified:
%
%    16 April 2012
%
%  Author:
%
%    Mikel Landajuela
%
%  Input:
%
%    integer METHOD.
%    1, Upwind nonconservative;
%    2, Upwind conservative;
%    3, Lax Friedrichs;
%    4, Lax Wendroff;
%    5, MacCormack;
%    6, Godunov.
%
%    function UI = IC_FUNCTION ( X ), a handle to the initial
%    condition function.
%
%    integer NX, the number of nodes.
%
%    integer NT, the number of time steps.
%
%    real T_MAX, the maximum time.
%
%    integer BC, defines the boundary conditions.
%    0, Dirichlet at A, Dirichlet at B.
%    1, Dirichlet at A, Neumann at B. (not implemented!)
%    2, Neumann at A, Dirichlet at B. (not implemented!)
%    3, Neumann at A, Neumann at B. (not implemented!)
%    4, Periodic, U(A) = U(B).
%
%  Output:
%
%    real U(NT+1,NX), the solution at each time and node.
%
  a = -1.0;
  b = +1.0;
  dx = ( b - a ) / nx ;
  x = linspace ( a, b, nx );

  dt = t_max / nt;
%
%  Set up the initial solution values.
%
  U = zeros ( nt + 1, nx );
  u0 = ic_function ( x );
  U(1,1:nx) = u0(1:nx);

  u = u0;
  unew = 0 * u;
%
%  Implementation of the numerical methods.
%
  for i = 1 : nt
    switch method
%
%  Upwind nonconservative.
%
      case 1

        if ( bc == 0 || bc == 1 )
          unew(1) = u(1);
        elseif ( bc == 4 )
          unew(1) = u(1) - dt/dx * u(1) .* ( u(1) - u(nx) );
        end

        unew(2:nx) = u(2:nx) - dt/dx * u(2:nx) .* ( u(2:nx) - u(1:nx-1) );
%
%  Upwind conservative.
%
      case 2

        if ( bc == 0 || bc == 1 )
          unew(1) = u(1);
        elseif ( bc == 4 )
          unew(1) = u(1) - dt/dx * ( f(u(1)) - f(u(nx)) );
        end

        unew(2:nx) = u(2:nx) - dt/dx * ( f(u(2:nx)) - f(u(1:nx-1)) );
%
%  Lax Friedrichs
%
      case 3

        if ( bc == 0 || bc == 1 )
          unew(1) = u(1);
        elseif ( bc == 4 )
          unew(1) = 0.5 * ( u(2) + u(nx) ) ...
            - 0.5 * dt / dx * ( f(u(2)) - f(u(nx)) );
        end

        unew(2:nx-1) = 0.5 * ( u(3:nx) + u(1:nx-2) ) ...
          - 0.5 * dt / dx * ( f(u(3:nx)) - f(u(1:nx-2)) );

        if ( bc == 0 || bc == 2 )
          unew(nx) = u(nx);
        elseif ( bc == 4 )
          unew(nx) = 0.5 * ( u(1) + u(nx-1) ) ...
            - 0.5 * dt / dx * ( f(u(1)) - f(u(nx-1)) );
        end
%
%  Lax Wendroff
%
      case 4

        if ( bc == 0 || bc == 1 )
          unew(1) = u(1);
        elseif ( bc == 4 )
          unew(1) = u(1) ...
            - 0.5 * dt/dx * ( f(u(2)) - f(u(nx)) ) ...
            + 0.5 * (dt/dx)^2 * ...
            ( df(0.5*(u(2) + u(1)))  .* ( f(u(2)) - f(u(1))  ) - ...
              df(0.5*(u(1) + u(nx))) .* ( f(u(1)) - f(u(nx)) ) );
        end

        unew(2:nx-1) = u(2:nx-1) ...
          - 0.5 * dt/dx * ( f(u(3:nx)) - f(u(1:nx-2)) ) ...
          + 0.5 * (dt/dx)^2 * ...
          ( df(0.5*(u(3:nx)   + u(2:nx-1))) .* ( f(u(3:nx))   - f(u(2:nx-1)) ) - ...
            df(0.5*(u(2:nx-1) + u(1:nx-2))) .* ( f(u(2:nx-1)) - f(u(1:nx-2)) ) );

        if ( bc == 0 || bc == 2 )
          unew(nx) = u(nx);
        elseif ( bc == 4 )
          unew(nx) = u(nx) ...
            - 0.5*dt/dx * ( f(u(1)) - f(u(nx-1)) ) ...
            + 0.5*(dt/dx)^2 * ...
            ( df(0.5*(u(1) + u(nx))) .* (f(u(1)) - f(u(nx))) - ...
            df(0.5*(u(nx) + u(nx-1))) .* (f(u(nx)) - f(u(nx-1))) );
        end
%
%  MacCormack
%
      case 5

        us(1:nx-1) = u(1:nx-1) - dt/dx * ( f(u(2:nx)) - f(u(1:nx-1)) );
        us(nx)     = u(nx)     - dt/dx * ( f(u(1))    - f(u(nx)) );

        if ( bc == 0 || bc == 1 )
          unew(1) = u(1);
        elseif ( bc == 4 )
          unew(1) = 0.5 * ( u(1) + us(1) )  ...
            - 0.5 * dt / dx * ( f(us(1)) - f(us(nx)) );
        end

        unew(2:nx-1) = 0.5 * ( u(2:nx-1) + us(2:nx-1) )  ...
          - 0.5 * dt / dx * ( f(us(2:nx-1)) - f(us(1:nx-2)) );

        if ( bc == 0 || bc == 2 )
          unew(nx) = u(nx);
        elseif ( bc == 4 )
          unew(nx) = 0.5 * ( u(nx) + us(nx) )  ...
            - 0.5 * dt / dx * ( f(us(nx)) - f(us(nx-1)) );
        end
%
%  Godunov
%
      case 6

        if ( bc == 0 || bc == 1 )
          unew(1) = u(1);
        elseif ( bc == 4 )
          unew(1) = u(1) - dt/dx * ( nf(u(1),u(2)) - nf(u(nx),u(1)) );
        end

        unew(2:nx-1) = u(2:nx-1) - dt/dx * ( nf(u(2:nx-1),u(3:nx)) ...
          - nf(u(1:nx-2),u(2:nx-1)) );

        if ( bc == 0 || bc == 2 )
          unew(nx) = u(nx);
        elseif ( bc == 4 )
          unew(nx) = u(nx) - dt/dx * ( nf(u(nx),u(1)) - nf(u(nx-1),u(nx)) );
        end

    end
%
%  Save the latest result.
%
    u = unew;
    U(i+1,:) = u(:);

  end

  return
end
function value = f ( u )

%*****************************************************************************80
%
%% F evaluates the conservation quantity.
%
%  Modified:
%
%    22 April 2012
%
%  Author:
%
%    Mikel Landajuela
%
%  Input:
%
%    real U, the current solution value.
%
%  Output:
%
%    real VALUE, the conservation quantity.
%
  value = 0.5 * u.^2;

  return
end
function value = df ( u )

%*****************************************************************************80
%
%% DF evaluates the derivative of the conservation quantity.
%
%  Modified:
%
%    22 April 2012
%
%  Author:
%
%    Mikel Landajuela
%
%  Input:
%
%    real U, the current solution value.
%
%  Output:
%
%    real VALUE, the derivative of the conservation quantity with respect to U.
%
  value = u;

  return
end
function value = nf ( u, v )

%*****************************************************************************80
%
%% NF evaluates the numerical flux for the Godunov method.
%
%  Modified:
%
%    16 April 2012
%
%  Author:
%
%    Mikel Landajuela
%
%  Input:
%
%    real U, the left value.
%
%    real V, the right value.
%
%  Output:
%
%    real VALUE, the numerical flux.
%
  for i = 1 : length ( u )

    if ( v(i) <= u(i) )
      if ( 0.0 < ( u(i) + v(i) ) / 2.0 )
        ustar(i) = u(i);
      else
        ustar(i) = v(i);
      end

    else

      if ( 0.0 < u(i) )
        ustar(i) = u(i);
      elseif ( v(i) < 0.0 )
        ustar(i) = v(i);
      else
        ustar(i) = 0.0;
      end

    end

  end

  value = f ( ustar );

  return
end
 
