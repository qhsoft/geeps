#!/usr/bin/env sh

python scripts/duplicate.py examples/cifar10/3parts/create_cifar10.sh 3

pdcp -R ssh -l root -w ^examples/cifar10/3parts/machinefile examples/cifar10/3parts/machinefile /root/geeps/apps/caffe/examples/cifar10/3parts/

pdcp -R ssh -l root -w ^examples/cifar10/3parts/machinefile examples/cifar10/3parts/create_cifar10.sh.* /root/geeps/apps/caffe/examples/cifar10/3parts/

pdsh -R ssh -l root -w ^examples/cifar10/3parts/machinefile "cd /root/geeps/apps/caffe/ &&  sh ./data/cifar10/get_cifar10.sh && ./examples/cifar10/3parts/create_cifar10.sh.%n"
