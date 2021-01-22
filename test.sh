#!/bin/bash

##########################################################################
# Install tflint: https://github.com/terraform-linters/tflint#installation
##########################################################################

TFLINT_VERSION=0.23.1
pwd
ls -al
TF_DIRS=("techtestmomentum/vpc/")
curl https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

for tf_directory in "${TF_DIRS[@]}"
do
    echo "linting ${tf_directory}"
    tflint $tf_directory
done
