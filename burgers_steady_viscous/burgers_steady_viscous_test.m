function burgers_steady_viscous_test ( )

%*****************************************************************************80
%
%% burgers_steady_viscous_test() tests burgers_steady_viscous().
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    04 December 2018
%
%  Author:
%
%    John Burkardt
%
  addpath ( '../burgers_steady_viscous' );

  timestamp ( );
  fprintf ( 1, '\n' );
  fprintf ( 1, 'burgers_steady_viscous_test():\n' );
  fprintf ( 1, '  MATLAB/Octave version %s\n', version ( ) );
  fprintf ( 1, '  Test BURGERS_STEADY_VISCOUS.\n' );

  bsv_test01 ( );
  pause ( 5 );
  bsv_test02 ( );
  pause ( 5 );
  bsv_test03 ( );
  pause ( 5 );
  bsv_test04 ( );
  pause ( 5 );
  bsv_test05 ( );
  pause ( 5 );
  bsv_test06 ( );
  bsv_test07 ( );
  pause ( 5 );
  bsv_test08 ( );
  pause ( 5 );

  tanh_plot ( );
  pause ( 5 );
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'burgers_steady_viscous_test():\n' );
  fprintf ( 1, '  Normal end of execution.\n' );
  fprintf ( 1, '\n' );
  timestamp ( );

  rmpath ( '../burgers_steady_viscous' );

  return
end
function timestamp ( )

%*****************************************************************************80
%
%% timestamp() prints the current YMDHMS date as a timestamp.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    14 February 2003
%
%  Author:
%
%    John Burkardt
%
  t = now;
  c = datevec ( t );
  s = datestr ( c, 0 );
  fprintf ( 1, '%s\n', s );

  return
end

