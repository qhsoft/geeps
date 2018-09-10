#!/usr/bin/env sh

pdsh -R ssh -w ^examples/cifar10/1parts/machinefile "pkill caffe_geeps"
