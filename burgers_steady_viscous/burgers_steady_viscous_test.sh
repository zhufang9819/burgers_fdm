#! /bin/bash
#
matlab -nodisplay -nosplash -nodesktop -batch \
  "run('burgers_steady_viscous_test.m');exit;" > burgers_steady_viscous_test.txt
if [ $? -ne 0 ]; then
  echo "Run error."
  exit
fi
#
echo "Normal end of execution."
