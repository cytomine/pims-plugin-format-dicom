#!/bin/bash

set -o xtrace
set -o errexit

echo "************************************** Create dependency image ******************************************"

file='./ci/version'
VERSION_NUMBER=$(<"$file")

echo "Launch Create dependency image for $VERSION_NUMBER"

git clone --branch jenkins-integration https://github.com/cytomine/pims ./ci/app

mkdir -p ./ci/app/plugins/pims-plugin-format-dicom/
#cp -r ./env ./ci/app/plugins/pims-plugin-format-dicom/
cp -r ./pims_plugin_format_dicom ./ci/app/plugins/pims-plugin-format-dicom/
#cp -r ./pims_plugin_format_dicom.egg-info ./ci/app/plugins/pims-plugin-format-dicom/
cp -r ./tests ./ci/app/plugins/pims-plugin-format-dicom/
cp ./setup.py ./ci/app/plugins/pims-plugin-format-dicom/

git clone https://github.com/cytomine/pims-plugin-format-openslide ./ci/app/plugins/pims-plugin-format-openslide

docker build --rm -f scripts/docker/Dockerfile-dependencies -t  cytomine/pims-plugin-format-dicom-dependencies:v$VERSION_NUMBER .
