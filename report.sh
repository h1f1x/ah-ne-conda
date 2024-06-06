#!/bin/bash

set -e
set +x 
set -o pipefail

# trap any error, and print something
trap 'echo "🚫 An error occurred in: $0 at line: $LINENO. Exiting..."' ERR


echo "🚀 Display and store the global environment: "
which python 
conda info

# Here is what the spark docu wrote
echo "👮‍♀️ Creating a conda environment with the instructions from the spark documentation ..."

conda create -y -n pyspark_conda_env -c conda-forge conda-pack
# The orginal command was working in interactive bash, but not in a script!
# So we use conda run to run the command in the conda environment.
conda run -n pyspark_conda_env conda pack -f -o pyspark_conda_env.tar.gz

echo "✅ Done creating and packing a conda environment with the instructions from the spark documentation."

