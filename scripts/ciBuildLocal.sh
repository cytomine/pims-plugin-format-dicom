#!/bin/bash

set -o xtrace
set -o errexit
set -a

rm -rf ./ci
mkdir ./ci
#echo "v0.0.0" > ./ci/version
./scripts/ciBuildVersion.sh

./scripts/ciCreateDependencyImage.sh

./scripts/ciTest.sh


rm -rf ./ci
mkdir ./ci
