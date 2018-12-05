#!/usr/bin/env sh


~/caffe/build/tools/caffe train --solver=examples/cifar10/1parts/inception_solver.prototxt.caffe 2>&1 | tee caffe_snapshot/log-data
