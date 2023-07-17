function u = burgers_steady_viscous ( a, b, alpha, beta, nu, n, output )

%*****************************************************************************80
%
%% burgers_steady_viscous() applies Newton's method to a discretized steady viscous Burgers equation.
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
%  Input:
%
%    real A, B, the left and right endpoints.
%
%    real ALPHA, BETA, the Dirichlet boundary values at the left and right.
%
%    real NU, the viscosity.  Normally, 0 < NU.
%
%    integer N, the number of nodes to use between A and B.
%
%    logical OUTPUT, is TRUE if printout is desired.
%
%  Output:
%
%    real U(N), the computed discretized solution.
%
  if ( n < 2 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'BURGERS_STEADY_VISCOUS - Fatal error!\n' );
    fprintf ( 1, '  N < 2.\n' );
    error ( 'BURGERS_STEADY_VISCOUS - Fatal error!\n' );
  end
%
%  Set some iteration parameters.
%
  newton_step_max = 5000;
  newton_resid_tol = sqrt ( eps ); % 这里的eps是Matlab自带的，eps = 2.2204e-16
  newton_step_tol = sqrt ( eps );
%
%  Use equally spaced nodes from A to B.
%
  dx = ( b - a ) / ( n - 1 ); % 有n个点，端点是a,b
%
%  The initial guess will be the linear interpolant to the boundary conditions.
%
  u = ( linspace ( alpha, beta, n ) )'; % 将 u 初始化为 边界为 (alpha, beta) 的n值数组
%
%  Prepare for the Newton iteration.
%
  J = sparse ( [], [], [], n, n, 3 * n );
  newton_step = 0;

  if ( output )
    fprintf ( 1, '\n' );
    fprintf ( 1, '  Step  ||F(U)||\n' );
    fprintf ( 1, '\n' );
  end 

  while ( newton_step <= newton_step_max )
    
    % 计算残差 f
    f(1,1) = u(1) - alpha; % 边界点a的残差

%   for i = 2 : n - 1
%     f(i,1) = 0.5 * ( u(i+1)^2 - u(i-1)^2 ) / ( 2.0 * dx ) ...
%          - nu * ( u(i+1) - 2.0 * u(i) + u(i-1) ) / ( dx^2 );
%   end
    
    % 计算f在u(2), ... , u(n-1) 处的残差 
    f(2:n-1,1) = 0.5 * ( u(3:n).^2 - u(1:n-2).^2 ) / ( 2.0 * dx ) ...
           - nu * ( u(3:n) - 2.0 * u(2:n-1) + u(1:n-2) ) / ( dx^2 );

    f(n,1) = u(n) - beta; % 边界点b的残差
    f_norm = norm ( f, inf ); % 计算f的无穷范数（最大值）

    if ( output )
      fprintf ( 1, '  %4d  %g\n', newton_step, f_norm );
    end

    if ( f_norm < newton_resid_tol ) % 要是残差足够小，就退出循环
      break
    end
%
%  Define the Jacobian matrix.
%
    J(1,1) = 1.0; % f(1,1) 对 u(1) 的导数，因为是f(1,1) = u(1) - alpha, 
    % 且 f(1,1)对 u(2), ... , u(n) 的导数都是0

    for i = 2 : n - 1
      J(i,i-1) = - 2.0 * u(i-1) / ( 4.0 * dx )       - nu / dx^2; % 计算 f(i,1) 对 u(i-1) 的导数 (2 <= i <= n-1)
      J(i,i)   =                                 2.0 * nu / dx^2; % 计算 f(i,1) 对 u(i) 的导数 (2 <= i <= n-1)
      J(i,i+1) =   2.0 * u(i+1) / ( 4.0 * dx )       - nu / dx^2; % 计算 f(i,1) 对 u(i+1) 的导数 (2 <= i <= n-1)
    end
    J(n,n) = 1.0; % f(n,1) 对 u(n) 的导数，因为是f(n,1) = u(n) - beta, 
    % 且 f(n,1)对 u(1), ... , u(n-1) 的导数都是0
%
%  Solve the linear system J * du = -f to get the Newton update.
%
    du = J \ f;
    du_norm = norm ( du, inf );

    u_norm = norm ( u, inf );
    if ( du_norm < newton_step_tol * ( u_norm + 1.0 ) )
      break
    end

    u = u - du;
    newton_step = newton_step + 1;

  end

  if ( newton_step_max < newton_step )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'BURGERS_STEADY_VISCOUS - Warning!\n' );
    fprintf ( 1, '  The Newton iteration did not converge.\n' );
  end

  return
end
