#!/bin/bash
#-----------------------------------------------------------------------------
#   Copyright 2020 Velexi Corporation
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#-----------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Cookiecutter post-generation script
#------------------------------------------------------------------------------

# --- Preparations

# DVC remote storage parameters
dvc_remote_storage_provider="{{ cookiecutter.dvc_remote_storage_provider }}"

# Data directory
data_dir="data"

# --- Update project template files based on user configuration

# Remove DATASET-NOTICE file if dataset does not include third-party data
if [[ "{{ cookiecutter.includes_third_party_data }}" = "no" ]]; then
    rm DATASET-NOTICE
fi

# Remove SOFTWARE-NOTICE file if software license is not Apache License 2.0
if [[ "{{ cookiecutter.software_license }}" != "Apache License 2.0" ]]; then
    rm SOFTWARE-NOTICE
fi

# --- Set up temporary poetry environment

echo "Set up temporary poetry environment..."
echo "--------------------------------------"
echo

# Install DVC
if [ "$dvc_remote_storage_provider" = "local" ]; then
    poetry add dvc
elif [ "$dvc_remote_storage_provider" = "aws" ]; then
    poetry add dvc[s3]
fi

# Install FastDS
poetry add fastds

# Activate poetry environment
source $(poetry env info --path)/bin/activate

# --- Initialize Git repository

echo "Initialize Git repository..."
git init
# TODO: Add all non-data files
git add poetry.lock
git commit -m "Initial commit."

# --- Initialize DVC

echo "Initialize DVC..."
fds init
fds commit "Initialize DVC."

# --- Transfer tracking of $data_dir directory from Git to DVC

echo "Transfer tracking of $data_dir directory from Git to DVC..."

# Remove $data_dir from Git management
git rm -r --cached $data_dir

# Add $data_dir to DVC management
dvc add $data_dir

# Add DVC files to git repository
git add $data_dir.dvc

# Commit change
fds commit "Transfer tracking of '$data_dir' directory from Git to DVC."

# --- Clean up

echo "Clean up..."

# Remove temporary poetry environment
poetry_env=`poetry env list | grep dataset-name | cut -d " " -f 1`
poetry env remove $poetry_env
