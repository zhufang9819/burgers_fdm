function un = ic_shock ( x )

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
%    real UN(*), the value of the initial condition at each node.
%
  un = ( x <= 0.0 );

  return
end
