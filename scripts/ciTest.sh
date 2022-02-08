#!/bin/bash

set -o xtrace
set -o errexit

echo "************************************** Launch tests ******************************************"

file='./ci/version'
VERSION_NUMBER=$(<"$file")

echo "Launch tests for $VERSION_NUMBER"
mkdir "$PWD"/ci/test-reports
touch "$PWD"/ci/test-reports/pytest_unit.xml
sudo docker build --rm -f scripts/docker/Dockerfile-test --build-arg VERSION_NUMBER=$VERSION_NUMBER -t  cytomine/pims-plugin-format-dicom-test .

containerId=$(docker create -v "$PWD"/ci/test-reports:/app/ci/test-reports  cytomine/pims-plugin-format-dicom-test )

docker start -ai  $containerId
docker rm $containerId
