#!/bin/bash
#------------------------------------------------------------------------------
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
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Cookiecutter post-generation script
#------------------------------------------------------------------------------

# --- Preparations

# Dataset name
project_name="{{ cookiecutter.__project_name }}"

# DVC remote storage parameters
dvc_remote_storage_provider="{{ cookiecutter.dvc_remote_storage_provider }}"

# Data directory
data_dir="data"

# --- Update project template files based on user configuration

# Replace DATASET-LICENSE with an empty file when dataset_license is set to None
if [[ "{{ cookiecutter.dataset_license }}" = "None" ]]; then
    rm DATASET-LICENSE
    touch DATASET-LICENSE
fi

# Remove DATASET-NOTICE file if dataset does not include third-party data
if [[ "{{ cookiecutter.includes_third_party_data }}" = "no" ]]; then
    rm DATASET-NOTICE
fi

# Remove SOFTWARE-NOTICE file if software license is not Apache License 2.0
if [[ "{{ cookiecutter.software_license }}" != "Apache License 2.0" ]]; then
    rm SOFTWARE-NOTICE
fi

# --- Set up temporary poetry environment

echo
echo "-------------------------------------------------------------------------------"
echo "Set up temporary poetry environment"
echo

# Locally configure poetry to use in-project virtual environments
poetry config --local virtualenvs.in-project true

# Install DVC
if [ "$dvc_remote_storage_provider" = "aws" ]; then
    poetry add dvc[s3]
else
    poetry add dvc
fi

# Install FastDS
poetry add fastds

# Activate poetry environment
source $(poetry env info --path)/bin/activate

# --- Initialize Git repository

echo
echo "-------------------------------------------------------------------------------"
echo "Initialize Git repository"
echo

git init

# --- Install pre-commit hooks

echo
echo "-------------------------------------------------------------------------------"
echo "Install pre-commit hooks"
echo

pre-commit install

# --- Add template files to Git repository

echo
echo "-------------------------------------------------------------------------------"
echo "Add template files to Git repository"
echo

# Remove poetry.toml so that it's not added to the Git repository
rm poetry.toml

# Add initial files
git add .
git commit -m "Initial commit"

# --- Initialize DVC

echo
echo "-------------------------------------------------------------------------------"
echo "Initialize DVC"
echo

fds init
fds commit "Initialize DVC"

# --- Configure DVC

echo
echo "-------------------------------------------------------------------------------"
echo "Enable DVC auto-staging"
echo

dvc config core.autostage true
fds commit "Enable DVC auto-staging"

# --- Transfer tracking of $data_dir directory from Git to DVC

echo
echo "-------------------------------------------------------------------------------"
echo "Transfer tracking of $data_dir directory from Git to DVC"
echo

# Remove $data_dir from Git management
git rm -r --cached $data_dir

# Add $data_dir to DVC management
dvc add $data_dir

# Add DVC files to git repository
git add $data_dir.dvc

# Commit change
fds commit "Transfer tracking of '$data_dir' directory from Git to DVC"

# --- Clean up

echo
echo "-------------------------------------------------------------------------------"
echo "Clean up"
echo

# Remove temporary poetry environment
rm -rf .venv
