#! /bin/bash

this_path="$( cd "$(dirname "$0")" ; pwd -P )"
project_path=$this_path/../../../

source $this_path/build_westlakethesis.sh

echo "CD $project_path"
cd $project_path

degree="undergraduate"
types=("thesis")
periods=("final" "proposal")

mkdir -p dist

# westlakethesis only supports the "westlake" MajorFormat for undergraduate
build_westlakethesis $degree "westlake" "thesis" "final" "true" "doctor" "chinese"

for period in "${periods[@]}"; do
for type   in "${types[@]}";   do
    build_westlakethesis $degree "westlake" $type $period "false" "doctor" "chinese"
done
done

build_westlakethesis $degree "westlake" "design" "proposal" "false" "doctor" "chinese"
build_westlakethesis $degree "westlake" "design" "final"    "false" "doctor" "chinese"
