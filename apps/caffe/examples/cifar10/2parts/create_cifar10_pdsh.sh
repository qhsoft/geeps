#!/usr/bin/env sh

python scripts/duplicate.py examples/cifar10/2parts/create_cifar10.sh 2

pdcp -R ssh -l root -w ^examples/cifar10/2parts/machinefile examples/cifar10/2parts/machinefile /root/geeps/apps/caffe/examples/cifar10/2parts/

pdcp -R ssh -l root -w ^examples/cifar10/2parts/machinefile examples/cifar10/2parts/create_cifar10.sh.* /root/geeps/apps/caffe/examples/cifar10/2parts/

pdsh -R ssh -l root -w ^examples/cifar10/2parts/machinefile "cd /root/geeps/apps/caffe/ &&  sh ./data/cifar10/get_cifar10.sh && ./examples/cifar10/2parts/create_cifar10.sh.%n"
