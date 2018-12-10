#!/usr/bin/env sh

pdsh -R ssh -l root -w ^examples/cifar10/GooleNet/machinefile "pkill caffe_geeps"

python scripts/duplicate.py examples/cifar10/GoogleNet/train_val.prototxt 3
python scripts/duplicate.py examples/cifar10/GoogleNet/solver.prototxt 3
if [-d ]
mkdir GoogleNet3
LOG=GoogleNet3/log-data

pdcp -R ssh -l root -w ^examples/cifar10/GoogleNet/machinefile examples/cifar10/GoogleNet/solver.prototxt.* /root/geeps/apps/caffe/examples/cifar10/GoogleNet/
pdcp -R ssh -l root -w ^examples/cifar10/GoogleNet/machinefile examples/cifar10/GoogleNet/ps_config_inception /root/geeps/apps/caffe/examples/cifar10/GoogleNet/
pdcp -R ssh -l root -w ^examples/cifar10/GoogleNet/machinefile examples/cifar10/3parts/train_val.prototxt.* /root/geeps/apps/caffe/examples/cifar10/GoogleNet/

pdsh -R ssh -l root -w ^examples/cifar10/GoogleNet/machinefile "cd /root/geeps/apps/caffe/ && ./build/tools/caffe_geeps train --solver=examples/cifar10/GoogleNet/solver.prototxt --ps_config=examples/cifar10/GoogleNet/ps_config_inception --machinefile=examples/cifar10/GoogleNet/machinefile --worker_id=%n" 2>&1 | tee ${LOG}
