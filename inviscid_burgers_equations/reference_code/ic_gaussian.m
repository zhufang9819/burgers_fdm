function un = ic_gaussian ( x )

%*****************************************************************************80
%
%% ic_gaussian() evaluates the initial condition for a Gaussian.
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
  xmin = min ( x );
  xmax = max ( x );
  xave = 0.5 * ( xmax - xmin );
  xn = ( x - xave ) / ( xmax - xmin );

  un = exp ( - 0.5 * xn.^2 );

  return
end
