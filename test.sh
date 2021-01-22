#!/bin/bash

##########################################################################
# Install tflint: https://github.com/terraform-linters/tflint#installation
##########################################################################

pwd
ls -al
TF_DIRS=("techtestmomentum/vpc/")

for tf_directory in "${TF_DIRS[@]}"
do
    echo "linting ${tf_directory}"
    tflint $tf_directory
done
