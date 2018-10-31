#!/usr/bin/env sh

pdsh -R ssh -w ^examples/cifar10/3parts/machinefile "pkill caffe_geeps"
