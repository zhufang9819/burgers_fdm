function fd1d_burgers_leap_test ( )

%*****************************************************************************80
%
%% fd1d_burgers_leap_test() tests fd1d_burgers_leap().
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    13 January 2019
%
%  Author:
%
%    John Burkardt
%
  addpath ( '../fd1d_burgers_leap' )

  timestamp ( );
  fprintf ( 1, '\n' );
  fprintf ( 1, 'fd1d_burgers_leap_test():\n' );
  fprintf ( 1, '  MATLAB/Octave version %s\n', version ( ) );
  fprintf ( 1, '  Test fd1d_burgers_leap().\n' );

  fd1d_burgers_leap ( );
  filename = 'fd1d_burgers_leap_test.png';
  print ( '-dpng', filename );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Saving plot as "%s".\n', filename );
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'fd1d_burgers_leap_test():\n' );
  fprintf ( 1, '  Normal end of execution.\n' );
  fprintf ( 1, '\n' );
  timestamp ( );

  rmpath ( '../fd1d_burgers_leap' )

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

