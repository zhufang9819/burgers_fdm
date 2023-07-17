function ui = ic_shock ( x )

%*****************************************************************************80
%
%% ic_shock() evaluates the initial condition for a shock.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    22 April 2012
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    real X(*), the node coordinates.
%
%  Output:
%
%    real UI(*), the value of the initial condition at each node.
%
  ui = ( x <= 0.0 );

  return
end
