{{ cookiecutter.dataset_name }}
===============================================================================

___Authors___  
CONTRIBUTOR NAME `<contributor@example.com>`

-------------------------------------------------------------------------------

Contents
--------

1. [Overview][#1]

    1.1. [Dataset Organization][#1.1]

    1.2. [Dataset Conventions][#1.2]

    1.3. [License][#1.3]

    1.4. [Supporting Software Tools][#1.4]

2. [Using the Dataset][#2]

    2.1. [Importing the Dataset][#2.1]

    2.2. [Updating the Dataset][#2.2]

3. [Maintaining the Dataset][#3]

    3.1. [Adding Data][#3.1]

    3.2. [Updating Data][#3.2]

    3.3. [Removing Data][#3.3]

    3.4. [Releasing an Official Dataset Version][#3.4]

4. [Known Issues][#4]

5. [References][#5]

-------------------------------------------------------------------------------

## 1. Overview

Brief description of the dataset.

### 1.1. Dataset Organization

```
├── README.md          <- this file
├── RELEASE-NOTES.md   <- dataset release notes
├── DATASET-LICENSE    <- license for data components of the dataset
├{% if cookiecutter.includes_third_party_data == "yes" %}── DATASET-NOTICE     <- copyright notices for third-party data included in
│                         the dataset
├{% endif %}── SOFTWARE-LICENSE   <- license for software components of the dataset
├{% if cookiecutter.software_license == "Apache License 2.0" %}── SOFTWARE-NOTICE    <- copyright notice for the software components of the
│                         dataset
├{% endif %}── Makefile           <- Makefile containing useful shortcuts (`make` rules).
├── pyproject.toml     <- Python project metadata file
├── poetry.lock        <- Poetry lockfile
├── bin/               <- scripts and programs for managing the dataset
├── data/              <- directory containing data for dataset
│   └── VERSION        <- version of the latest official release of the dataset
├── docs/              <- dataset documentation
└── extras/            <- additional files and references that may be useful
                          for dataset maintenance
```

### 1.2. Dataset Conventions

#### Data

* `data` directory. All data files should be placed in the `data` directory.

  * Depending on the nature of the dataset, it may be useful to organize the
  data files into sub-directories (e.g., by type of data).

* `data/VERSION` file. The `data/VERSION` file contains the version number of
  the latest official release of the dataset. It is generated automatically
  and _should not be manually edited_.

#### Documentation

* `README.md` file. The `README.md` file should contain

  * a high-level description of the dataset and

  * instructions for software tools used to create and maintain the dataset.

* `docs` directory. The `docs` directory should be used for detailed
  documentation for the dataset (i.e., data and supporting software tools).

#### Supporting Software Tools

* `bin` directory. The `bin` directory should be used for supporting software
  tools (e.g., data capture and processing scripts) developed to help maintain
  the dataset.

* `pyproject.toml` file. Python dependencies for supporting tools should be
  maintained in the `pyproject.toml` file. Most of the time, `poetry` utility
  will appropriately update `pyproject.toml` as dependencies are added or
  removed.

* `extras` directory. The `extras` directory should be used for ancillary files
  (e.g., `direnv` configuration template, general reference documents for tools
  that are not dataset-specific).

### 1.3. License
{% if cookiecutter.dataset_license == "CC-BY-4.0 license" %}
The data components in this dataset is covered under the Creative Commons
Attribution 4.0 International Public License (included in the `DATASET-LICENSE`
file).{% endif %}{% if cookiecutter.includes_third_party_data == "yes" %} Licenses for third-party data included in this dataset are contained in
the `DATASET-NOTICE` file.{% endif %}
{% if cookiecutter.software_license == "Apache License 2.0" %}
The software components of this repository are covered under the Apache License
2.0 (included in the `SOFTWARE-LICENSE` file). The copyright for the software
components is contained in the `SOFTWARE-NOTICE` file.
{% else %}
The software components of this repository are covered under the license
contained in the `SOFTWARE-LICENSE` file.
{% endif %}

### 1.4. Supporting Software Tools

List of supporting software tools for creating and maintaining dataset.

* Tool #1

  * __Usage__. Instructions for use of Tool #1 to create and maintain dataset.

* Tool #2

  * __Usage__. Instructions for use of Tool #2 to create and maintain dataset.

#### Software Dependencies

##### Base Requirements

* [Python][python] (>={{ cookiecutter.python_version | trim("~") | trim("^") }})
* [Poetry][poetry] (>=1.2)

##### Python Packages

See the `[tool.poetry.dependencies]` section of the `pyproject.toml` file.

-------------------------------------------------------------------------------

## 2. Using the Dataset

### 2.1. Importing the Dataset

To use the dataset a "read-only" manner (i.e., without maintenance code),
import the dataset after initializing DVC in the working directory.

1. Initialize DVC.

   ```
   $ cd /PATH/TO/PROJECT
   $ dvc init
   ```

   In the example commands above, `/PATH/TO/PROJECT` should be replaced
   by the path to the directory that where the dataset will be used.

2. Change to the directory where the imported dataset will be stored.

    ```
    $ cd /PATH/TO/DATA
    ```

    In the example command above, `/PATH/TO/DATA` should be replaced by the
    path to the data directory.

3. Import the dataset.

    ```
    $ dvc import URL data -o /LOCAL/PATH
    ```

    In the example command above, the following substitutions should be made:

     * `URL` should be replaced by URL of the Git repository for the dataset.

     * `/LOCAL/PATH` should be replaced by the local path relative to
       `/PATH/TO/DATA` where the dataset should be placed.

    For example, if a dataset repository based on this template repository is
    located at

    `https://github.com/account/cool-dataset`

    and we would like to to place the dataset into a directory named
    `data/cool-dataset`, we would use the following command:

    ```
    $ dvc import https://github.com/account/cool-dataset data -o data/cool-dataset
    ```

### 2.2. Updating the Dataset

If a previously imported dataset has been updated, the local copy of the
dataset can be brought update date by using the `dvc update` command.

```
$ dvc update DATASET.dvc
```

In the example command above, the following substitutions should be made:

* `DATASET.dvc` should be replaced by the `.dvc` file that was generated when
  the dataset was imported.

-------------------------------------------------------------------------------

## 3. Maintaining the Dataset

### 3.1. Adding Data

1. Add the data files to the `data` directory.

2. Add the contents of `data` to the data tracked by DVC.

   ```
   $ fds add data
   ```

3. Commit the dataset changes to the local Git repository.

   ```
   $ fds commit "Add initial version of data"
   ```

4. Push the dataset changes to the remote Git repository and DVC remote
   storage.

   ```
   $ fds push
   ```

### 3.2. Updating Data

1. Update the data files in the `data` directory.

2. Update the data tracked by DVC with the new content of the `data` directory.

   ```
   $ fds add data
   ```

3. Commit the dataset changes to the local Git repository.

   ```
   $ fds commit "Update dataset"
   ```

4. Push the dataset changes to the remote Git repository and DVC remote
   storage.

   ```
   $ fds push
   ```

### 3.3. Removing Data

1. Remove the data files from the `data` directory.

2. Update the data tracked by DVC with the new content of the `data` directory.

   ```
   $ fds add data
   ```

3. Commit the dataset changes to the local Git repository.

   ```
   $ fds commit "Update dataset"
   ```

4. Push the dataset changes to the remote Git repository and DVC remote
   storage.

   ```
   $ fds push
   ```

### 3.4. Releasing an official dataset version

1. Make sure that the dataset has been updated ([Section 3.2][#3.2])

2. Update the `README.md` file.

3. Increment the version number in `pyproject.toml`.

4. Update `data/VERSION`.

   ```
   $ cd data
   $ poetry version -s > VERSION
   ```

5. ___Recommended___. Update the release notes for the dataset to include any
   major changes from the previous released version of the dataset.

7. Create a tag for the release in git.

    ```
    $ git tag `poetry version -s`
    $ git push --tags
    ```

6. _Optional_. If the Git repository for the dataset is hosted on GitHub (or
   analogous service), create a release associated with the git tag created
   in Step #4.

------------------------------------------------------------------------------

## 4. Known Issues

* List of known issues with the dataset.

-------------------------------------------------------------------------------

## 5. References

* [DVC Documentation][dvc-docs]

* [FastDS][fastds]

------------------------------------------------------------------------------

[-----------------------------INTERNAL LINKS-----------------------------]: #

[#1]: #1-overview
[#1.1]: #11-dataset-organization
[#1.2]: #12-dataset-conventions
[#1.3]: #13-license
[#1.4]: #14-supporting-software-tools

[#2]: #2-using-the-dataset
[#2.1]: #21-importing-the-dataset
[#2.2]: #22-updating-the-dataset

[#3]: #3-maintaining-the-dataset
[#3.1]: #31-adding-data
[#3.2]: #32-updating-data
[#3.3]: #33-removing-data
[#3.4]: #34-releasing-an-official-dataset-version

[#4]: #4-known-issues

[#5]: #5-references

[-----------------------------EXTERNAL LINKS-----------------------------]: #

[dvc-docs]: https://dvc.org/doc

[fastds]: https://github.com/DAGsHub/fds

[poetry]: https://python-poetry.org/

[python]: https://www.python.org/
