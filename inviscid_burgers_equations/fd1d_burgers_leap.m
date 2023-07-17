function fd1d_burgers_leap ( )

%*****************************************************************************80
%
%% fd1d_burgers_leap() solves the nonviscous Burgers equation using leapfrogging.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    18 August 2010
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'FD1D_BURGERS_LEAP:\n' );
  fprintf ( 1, '  MATLAB/Octave version %s\n', version ( ) );
  fprintf ( 1, '  Solve the non-viscous time-dependent Burgers equation,\n' );
  fprintf ( 1, '  using the leap-frog method.\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Equation to be solved:\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '    du/dt + u * du/dx = 0\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  for x in [ a, b ], for t in [t_init, t_last]\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  with initial conditions:\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '    u(x,o) = u_init\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  and boundary conditions:\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '    u(a,t) = u_a(t), u(b,t) = u_b(t)\n' );
%
%  Set and report the problem parameters.
%
  n = 21;
  a = -1.0;
  b = +1.0;
  dx = ( b - a ) / ( n - 1 );
  step_num = 30;
  t_init = 0.0;
  t_last = 3.0;
  dt = ( t_last - t_init ) / step_num;

  fprintf ( 1, '\n' );
  fprintf ( 1, '  %f <= X <= %f\n', a, b );
  fprintf ( 1, '  Number of nodes = %d\n', n );
  fprintf ( 1, '  DX = %f\n', dx );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  %f <= t <= %f\n', t_init, t_last );
  fprintf ( 1, '  Number of time steps = %d\n', step_num );
  fprintf ( 1, '  DT = %f\n', dt );

  x = linspace ( a, b, n );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  X:\n' );
  fprintf ( 1, '\n' );
  for ilo = 1 : 5 : n
    ihi = min ( ilo + 4, n );
    for i = ilo : ihi
      fprintf ( 1, '  %16f', x(i) );
    end
    fprintf ( 1, '\n' );
  end
%
%  Set the initial condition,
%  and apply boundary conditions to first and last entries.
%
  step = 0;
  t = t_init;
  un(1:n,1) = u_init ( n, x, t );
  un(1,1) = u_a ( x(1,1), t );
  un(n,1) = u_b ( x(n,1), t );

  report ( step, step_num, n, x, t, un );
  plot ( x, un );
  grid ( 'on' );
  title ( sprintf ( 'Step %d, Time %f', step, t ) );
%
%  Use Euler's method to get the first step.
%
  step = 1;
  t = ( ( step_num - step ) * t_init   ...
      + (            step ) * t_last ) ...
      / ( step_num        );
  uc(1:n,1) = un(1:n,1);

  un(2:n-1,1) = uc(2:n-1,1) - dt * uc(2:n-1,1) ...
    .* ( uc(3:n,1) - uc(1:n-2,1) ) / 2.0 / dx;

  un(1,1) = u_a ( x(1,1), t );
  un(n,1) = u_b ( x(n,1), t );

  report ( step, step_num, n, x, t, un );
  plot ( x, un );
  grid ( 'on' );
  title ( sprintf ( 'Step %d, Time %f', step, t ) );
%
%  Subsequent steps use the leapfrog method.
%
  for step = 2 : step_num

    t = ( ( step_num - step ) * t_init   ...
        + (            step ) * t_last ) ...
        / ( step_num        );

    uo(1:n,1) = uc(1:n,1);
    uc(1:n,1) = un(1:n,1);

    un(2:n-1,1) = uo(2:n-1,1) - dt * uc(2:n-1,1) ...
      .* ( uc(3:n,1) - uc(1:n-2,1) ) / dx;

    un(1,1) = u_a ( x(1,1), t );
    un(n,1) = u_b ( x(n,1), t );

    report ( step, step_num, n, x, t, un );

    plot ( x, un );
    grid ( 'on' );
    title ( sprintf ( 'Step %d, Time %f', step, t ) );

  end
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'FD1D_BURGERS_LEAP:\n' );
  fprintf ( 1, '  Normal end of execution.\n' );

  return
end
function report ( step, step_num, n, x, t, u )

%*****************************************************************************80
%
%% report() prints or plots or saves the data at the current time step.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    18 August 2010
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer STEP, the index of the current step,
%    between 0 and STEP_NUM.
%
%    integer STEP_NUM, the number of steps to take.
%
%    integer N, the number of nodes.
%
%    real X(N), the coordinates of the nodes.
%
%    real T, the current time.
%
%    real U(N), the initial values U(X,T).
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '  STEP = %d\n', step );
  fprintf ( 1, '  TIME = %f\n', t );
  fprintf ( 1, '\n' );
  for ilo = 1 : 5 : n
    ihi = min ( ilo + 4, n );
    for i = ilo : ihi
      fprintf ( 1, '  %14g', u(i) );
    end
    fprintf ( 1, '\n' );
  end

  return
end
function ua = u_a ( x, t )

%*****************************************************************************80
%
%% u_a() sets the boundary condition for U at A.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    18 August 2010
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    real X, T, the position and time.
%
%  Output:
%
%    real UA, the prescribed value of U(X,T).
%
  ua = + 0.5;

  return
end
function ub = u_b ( x, t )

%*****************************************************************************80
%
%% u_b() sets the boundary condition for U at B.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    18 August 2010
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    real X, T, the position and time.
%
%  Output:
%
%    real UB, the prescribed value of U(X,T).
%
  ub = - 0.5;

  return
end
function u = u_init ( n, x, t )

%*****************************************************************************80
%
%% u_init() sets the initial condition for U.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    18 August 2010
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer N, the number of nodes.
%
%    real X(N), the coordinates of the nodes.
%
%    real T, the current time.
%
%  Output:
%
%    real U(N), the initial values U(X,T).
%
  ua = u_a ( x(1,1), t );
  ub = u_b ( x(n,1), t );

  q = 2.0 * ( ua - ub ) / pi;
  r = ( ua + ub ) / 2.0;
%
%  S can be varied.  It is the slope of the initial condition at the midpoint.
%
  s = 1.0;
  u(1:n,1) = ( 2 * x(1:n,1) - x(n,1) - x(1,1) ) ...
           / (                x(n,1) - x(1,1) );

  u(1:n,1) = - q * atan ( s * u(1:n,1) ) + r;

  return
end
 
