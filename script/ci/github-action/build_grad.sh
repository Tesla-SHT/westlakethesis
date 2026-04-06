#! /bin/bash

this_path="$( cd "$(dirname "$0")" ; pwd -P )"
project_path=$this_path/../../../

source $this_path/build_westlakethesis.sh

echo "CD $project_path"
cd $project_path

mkdir -p dist

# NOTE: graduate degree is not yet supported in westlakethesis.
# The builds below are disabled until graduate templates are added.

# build_westlakethesis $degree "westlake" "thesis" "final" "false" "master" "chinese"
# build_westlakethesis $degree "westlake" "thesis" "final" "false" "doctor" "chinese"
# build_westlakethesis $degree "westlake" "thesis" "final" "false" "doctor" "english"
