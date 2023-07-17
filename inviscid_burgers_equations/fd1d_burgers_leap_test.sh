#! /bin/bash
#
matlab -nodisplay -nosplash -nodesktop -batch \
  "run('fd1d_burgers_leap_test.m');exit;" > fd1d_burgers_leap_test.txt
if [ $? -ne 0 ]; then
  echo "Run error."
  exit
fi
#
echo "Normal end of execution."
