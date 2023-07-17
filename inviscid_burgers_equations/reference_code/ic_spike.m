function un = ic_spike ( x )

%*****************************************************************************80
%
%% ic_spike() evaluates the initial condition for a spike function.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    03 June 2020
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
  un = max ( 1.0 - 3.0 * abs ( x ), 0.0 );

  return
end
