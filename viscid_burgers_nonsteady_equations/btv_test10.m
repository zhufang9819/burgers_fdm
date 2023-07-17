function btv_test10 ( )

%*****************************************************************************80
%
%% btv_test10() tests burgers_time_viscous() with the shock initial condition.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    02 September 2015
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'btv_test10():\n' );
  fprintf ( 1, '  Test BURGERS_TIME_VISCOUS with the shock initial condition.\n' );
  fprintf ( 1, '  BC: U(left)=0, U''(right)=0 boundary.\n' );

  nx = 800;
  nt = 10000;
  t_max = 2.0;
  nu = 0.01;
  bc = 1;

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Initial condition: shock\n' );
  fprintf ( 1, '  Number of space nodes = %d\n', nx );
  fprintf ( 1, '  Number of time steps = %d\n', nt );
  fprintf ( 1, '  Final time T_MAX = %g\n', t_max );
  fprintf ( 1, '  Viscosity = %g\n', nu );
  fprintf ( 1, '  Boundary condition = %d\n', bc );

  U = burgers_time_viscous ( @ic_shock, nx, nt, t_max, nu, bc );

  x = linspace ( -1.0, +1.0, nx );

  figure ( 10 )

  plot ( x, U(1:1000:(nt+1),:), 'Linewidth', 3 )
  grid on
  xlabel ( '<-- X -->' )
  ylabel ( '<-- U(X,T) -->' )
  title ( 'Burgers equation solutions over time, initial condition shock' )

  filename = 'btv_test10.png';
  print ( '-dpng', filename )
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Saved plot as "%s"\n', filename );

  return
end
