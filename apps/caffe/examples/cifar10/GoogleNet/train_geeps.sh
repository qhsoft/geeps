#!/usr/bin/env sh

pdsh -R ssh -l root -w ^examples/cifar10/GoogleNet/machinefile "pkill caffe_geeps"
#pdsh -R ssh -l root -w ^examples/cifar10/GoogleNet/machinefile "mkdir /root/geeps/apps/caffe/examples/cifar10/GoogleNet"

python scripts/duplicate.py examples/cifar10/GoogleNet/train_val.prototxt 3
python scripts/duplicate.py examples/cifar10/GoogleNet/solver.prototxt 3

#mkdir GoogleNet3
LOG=GoogleNet3/log-data

if [ "$#" -eq 1 ]; then
  mkdir $1
  pwd > $1/pwd
  git status > $1/git-status
  git diff > $1/git-diff
  cp examples/cifar10/GoogleNet/train_geeps.sh $1/.
  cp examples/cifar10/GoogleNet/train_val.prototxt.template $1/.
  cp examples/cifar10/GoogleNet/solver.prototxt.template $1/.
  cp examples/cifar10/GoogleNet/machinefile $1/.
  cp examples/cifar10/GoogleNet/ps_config_inception $1/.
  LOG=$1/output.txt
fi

pdcp -r -R ssh -l root -w ^examples/cifar10/GoogleNet/machinefile build/* /root/geeps/apps/caffe/build/

pdcp -R ssh -l root -w ^examples/cifar10/GoogleNet/machinefile examples/cifar10/GoogleNet/solver.prototxt.* /root/geeps/apps/caffe/examples/cifar10/GoogleNet/
pdcp -R ssh -l root -w ^examples/cifar10/GoogleNet/machinefile examples/cifar10/GoogleNet/ps_config_inception /root/geeps/apps/caffe/examples/cifar10/GoogleNet/
pdcp -R ssh -l root -w ^examples/cifar10/GoogleNet/machinefile examples/cifar10/GoogleNet/train_val.prototxt.* /root/geeps/apps/caffe/examples/cifar10/GoogleNet/

pdsh -R ssh -l root -w ^examples/cifar10/GoogleNet/machinefile "cd /root/geeps/apps/caffe/ && ./build/tools/caffe_geeps train --solver=examples/cifar10/GoogleNet/solver.prototxt --ps_config=examples/cifar10/GoogleNet/ps_config_inception --machinefile=examples/cifar10/GoogleNet/machinefile --worker_id=%n" 2>&1 | tee ${LOG}