DVC Dataset Repository Template (v0.1.2)
========================================

___Authors___  
Kevin T. Chu `<kevin@velexi.com>`

------------------------------------------------------------------------------

Table of Contents
-----------------

1. [Overview][#1]

    1.1. [Package Contents][#1.1]

    1.2. [Software Dependencies][#1.2]

    1.3. [License][#1.3]

    1.4. [Supported DVC Remote Storage Providers][#1.4]

2. [Getting Started][#2]

    2.1. [Setting Up the Dataset Repository][#2.1]

3. [Usage][#3]

    3.1. [Conventions][#3.1]

    3.2. [Managing Datasets][#3.2]

    3.3. [Using Datasets][#3.3]

4. [References][#4]

------------------------------------------------------------------------------

## 1. Overview

This repository is intended to serve as a template for dataset repositories
managed by DVC. It encourages the following dataset management practices.

* Improve the reproducibility of research analysis (including machine learning
  experiments, data science analysis, and traditional scientific and
  engineering studies) by applying version control principles to datasets.

* Facilitate efficient exploration of datasets by standardizing the directory
  structure used to organize data.

* Increase reuse of datasets across projects by decoupling datasets from data
  analysis code.

* Simplify dataset maintenance by keeping the dataset management code
  (e.g., clean up scripts) with the dataset.

### 1.1. Package Contents

    README.md
    LICENSE
    VERSION
    config.yaml.template
    README.md.template
    RELEASE-NOTES.md.template
    LICENSE.template
    LICENSE-DATASET.template
    bin/
    data/
    template-docs/
    template-docs/extras

* `README.md`: this file (same as `README-DVC-Dataset-Repository.md` in the
  `template-docs` directory)

* `LICENSE`: license file for this dataset repository template (same as
  `LICENSE-DVC-Dataset-Repository.md` in the `template-docs` directory)

* `VERSION`: symbolic link to `data/VERSION` file that is intended to contain
  the dataset version

* `config.yaml.template`: template configuration for the dataset repository

    * The `template-docs/extras` directory contains an extra copy of
      `config.yaml.template` in case the original copy is accidentally lost.

* `*.template`: template files for the dataset repository

    * Template files are indicated by the `template` suffix and contain
      template parameters denoted by double braces (e.g. `{{ PKG_NAME }}`).
      Template files are intended to simplify the set up of the dataset
      repository. When used, they should be renamed to remove the `template`
      suffix.

* `bin`: directory where scripts and programs for maintaining the dataset
  (e.g., scripts to download data from public websites, scripts to clean up
  data) should be placed

* `data`: directory where dataset should be placed

* `template-docs`: directory containing documentation for this repository
  template

* `template-docs/extras`: directory containing example and template files

### 1.2. Software Dependencies

#### Base Requirements

* Python (>=3.9)
    * `pip`
* `git`
* `awk`
* `sed`

#### Optional Software

* `direnv`: only needed if using `direnv` to manage the Python virtual
  environment for the dataset repository.

### 1.3. License

The contents of this directory are covered under the `LICENSE` file contained
in the `template-docs` and root directories of this repository.

### 1.4. Supported DVC Remote Storage Providers

* Local file system

* Amazon S3

------------------------------------------------------------------------------

## 2. Getting Started

### 2.1. Setting Up the Dataset Repository

1. Install the required software dependencies.

2. (OPTIONAL) Set up a Python virtual environment for the dataset repository.

    * Copy `template-docs/extras/envrc.example` to the root directory of the
      dataset repository and rename it to `.envrc`.

    * Follow `direnv` instructions to enable `.envrc` file.

3. Prepare storage for DVC.

    * __Local__: Create directory on local file system for DVC to use for
      "remote" storage.

    * __AWS__: Create S3 bucket for DVC to use for remote storage.

4. Initialize the dataset repository.

    * Rename `config.yaml.template` to `config.yaml`.

    * Set the parameters for the dataset repository in `config.yaml`.

    * Run `init-repo.sh`.

      ```
      $ init-repo.sh config.yaml
      ```

    * Add the auto-generated `requirements.txt` file to git repository.

      ```
      $ git add requirements.txt
      $ git commit requirements.txt -m "Add requirements.txt"
      ```

5. Rename all of the template files with the `template` suffix removed
   (overwrite the original `README.md` and `LICENSE` files) and replace all
   template parameters with package-appropriate values.

------------------------------------------------------------------------------

## 3. Usage

### 3.1. Conventions

#### 3.1.1. `data` directory

* All data files should be placed in the `data` directory.

* Depending on the nature of the dataset, it may be useful to organize the
  data files into sub-directories (e.g., by type of data).

#### 3.1.2. `bin` directory

Tools (e.g., data capture and processing scripts) developed to help maintain
the dataset should be placed in the `bin` directory.

#### 3.1.3. `README.md` file

The `README.md` file should contain

* a description of the dataset and

* instructions for tools used to create and maintain the dataset.

#### 3.1.4. `data/VERSION` file

The `data/VERSION` file should contain the current version of the dataset.
We recommend using basic [semantic version numbers][semantic-versioning]
prefixed with a `v` (e.g. `v1.2.3`).

#### 3.1.5. `requirements.txt` file

Python packages required by tools for managing the dataset should be added to
the `requirements.txt` file that is automatically generated by the
`init-repo.sh` script.

#### 3.1.6. `LICENSE-DATASET` file

If the dataset managed by the repository is owned by a third-party, a
`LICENSE-DATASET` file containing the licensing term should be included with
the dataset repository. If dataset is not owned by a third-party, remove
the `LICENSE-DATASET.template` file from the root directory of the dataset
repository.

### 3.2. Managing Datasets

#### 3.2.1. Adding Data

1. Add data files to the `data` directory.

2. Add `data` to DVC tracking, and push the dataset to remote storage.

    ```
    $ dvc add data
    $ dvc push
    ```

3. Commit DVC-generated changes to `data.dvc` to the git repository.

    ```
    $ git commit data.dvc -m "Add initial version of dataset"
    $ git push
    ```

#### 3.2.2. Updating Data

1. Update data files in the `data` directory.

2. Update DVC tracking of `data` directory, and push the dataset to remote
   storage.

    ```
    $ dvc add data
    $ dvc push
    ```

3. Commit DVC-generated changes to `data.dvc` to the git repository.

    ```
    $ git commit data.dvc -m "Update dataset"
    $ git push
    ```

#### 3.2.3. Removing Data

1. Remove data files from the `data` directory.

2. Update DVC tracking of `data` directory, and push the dataset to remote
   storage.

    ```
    $ dvc add data
    $ dvc push
    ```

3. Commit DVC-generated changes to `data.dvc` to the git repository.

    ```
    $ git commit data.dvc -m "Remove data from dataset"
    $ git push
    ```

#### 3.2.4. Releasing an official dataset version

1. Make sure that the dataset has been updated ([Section 3.2.2][#3.2.2])

2. Update `README.md`.

3. Increment the version number in `data/VERSION`.

4. (RECOMMENDED) Update release notes for the dataset to include any major
   changes between the previous version of the dataset.

5. Create a tag for the release in git.

    ```
    $ git tag `cat data/VERSION`
    $ git push --tags
    ```

6. (OPTIONAL) If the git repository for the dataset is hosted on GitHub (or
   analogous service), create a release associated with the git tag created
   in Step #4.

### 3.3. Using Datasets

#### 3.3.1. Importing Datasets

To use a dataset managed by a DVC repository in a "read-only" manner (i.e.,
without maintenance code), import the dataset after initializing DVC in the
working directory.

1. Initialize DVC.

    ```
    $ cd /PATH/TO/PROJECT
    $ dvc init
    ```

    In the example commands above, `/PATH/TO/PROJECT` should be replaced by
    the path to the project directory.

2. Change to the directory in the project where data is stored.

    ```
    $ cd /PATH/TO/DATA
    ```

    In the example command above, `/PATH/TO/DATA/DIR` should be replaced by
    the path to the data directory for the project.

3. Import the dataset.

    ```
    $ dvc import URL /DVC/REPO/PATH -o /LOCAL/PATH
    ```

    In the example command above, the following substitutions should be made:

     * `URL` should be replaced by URL of the Git repository for the dataset.

     * `/DVC/REPO/PATH` should be replaced by the path within the DVC
       repository where data resides. For repositories based on this template
       repository, `/DVC/REPO/PATH` should most likely be set to `data`.

     * `/LOCAL/PATH` should be replaced by the local path relative to
       `/PATH/TO/DATA` where the dataset should be placed.

    For example, if a dataset repository based on this template repository is
    located at

    `https://github.com/account/cool-dataset`

    and we would like to to place the dataset into a directory named
    `dataset-1`, we would use the following command:

    ```
    $ dvc import https://github.com/account/cool-dataset data -o dataset-1
    ```

#### 3.3.2. Updating Datasets

If a previously imported dataset has been updated, the local copy of the
dataset can be brought update date by using the `dvc update` command.

```
$ dvc update DATASET.dvc
```

In the example command above, the following substitutions should be made:

* `DATASET.dvc` should be replaced by the `.dvc` file that was generated when
  the dataset was imported.

------------------------------------------------------------------------------

## 4. References

* [DVC Documentation][dvc-docs]

* [Semantic Versioning][semantic-versioning]

------------------------------------------------------------------------------

[-----------------------------INTERNAL LINKS-----------------------------]: #

[#1]: #1-overview
[#1.1]: #11-package-contents
[#1.2]: #12-software-dependencies
[#1.3]: #13-license
[#1.4]: #14-supported-dvc-remote-storage-providers

[#2]: #2-getting-started
[#2.1]: #21-setting-up-the-dataset-repository

[#3]: #3-usage
[#3.1]: #31-conventions
[#3.2]: #32-managing-datasets
[#3.2.1]: #321-adding-data
[#3.2.2]: #322-updating-data
[#3.2.3]: #323-removng-data
[#3.2.4]: #324-releasing-an-official-dataset-version
[#3.3]: #33-using-datasets

[#4]: #4-references

[-----------------------------EXTERNAL LINKS-----------------------------]: #

[dvc-docs]: https://dvc.org/doc

[semantic-versioning]: https://semver.org/
