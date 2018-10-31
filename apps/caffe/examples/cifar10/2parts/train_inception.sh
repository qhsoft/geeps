#!/usr/bin/env sh

pdsh -R ssh -l root -w ^examples/cifar10/2parts/machinefile "pkill caffe_geeps"

python scripts/duplicate.py examples/cifar10/2parts/inception_train_val.prototxt 2
python scripts/duplicate.py examples/cifar10/2parts/inception_solver.prototxt 2

LOG=logs2/log-data

if [ "$#" -eq 1 ]; then
  mkdir $1
  pwd > $1/pwd
  git status > $1/git-status
  git diff > $1/git-diff
  cp examples/cifar10/2parts/train_inception.sh $1/.
  cp examples/cifar10/2parts/inception_train_val.prototxt.template $1/.
  cp examples/cifar10/2parts/inception_solver.prototxt.template $1/.
  cp examples/cifar10/2parts/machinefile $1/.
  cp examples/cifar10/2parts/ps_config_inception $1/.
  LOG=$1/output.txt
fi

pdcp -R ssh -l root -w ^examples/cifar10/2parts/machinefile examples/cifar10/2parts/inception_solver.prototxt.* /root/geeps/apps/caffe/examples/cifar10/2parts/


pdcp -R ssh -l root -w ^examples/cifar10/2parts/machinefile examples/cifar10/2parts/inception_train_val.prototxt.* /root/geeps/apps/caffe/examples/cifar10/2parts/

pdsh -R ssh -l root -w ^examples/cifar10/2parts/machinefile "cd /root/geeps/apps/caffe/ && ./build/tools/caffe_geeps train --solver=examples/cifar10/2parts/inception_solver.prototxt --ps_config=examples/cifar10/2parts/ps_config_inception --machinefile=examples/cifar10/2parts/machinefile --worker_id=%n" 2>&1 | tee ${LOG}
