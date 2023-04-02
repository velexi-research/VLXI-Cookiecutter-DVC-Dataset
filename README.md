Velexi Dataset Cookiecutter
===============================

The [Velexi Dataset Cookiecutter][vlxi-cookiecutter-dataset] is intended to
streamline the process of creating a dataset that

* encourages data version management and

* is distribution-ready.

### Features

* A simple, consistent dataset directory structure

* Quick references for dataset maintenance tools (e.g., [FastDS][fastds])

* Integration with data quality tools (e.g., [pre-commit][pre-commit])

-------------------------------------------------------------------------------

Table of Contents
-----------------

1. [Usage][#1]

   1.1 [Cookiecutter Parameters][#1.1]

   1.2 [Setting Up a New Dataset][#1.2]

2. [Contributor Notes][#2]

   2.1. [License][#2.1]

   2.2. [Repository Contents][#2.2]

   2.3. [Software Requirements][#2.3]

   2.4. [Setting Up to Develop the Cookiecutter][#2.4]

   2.5. [Additional Notes][#2.5]

3. [Documentation][#3]

------------------------------------------------------------------------------

## 1. Usage

### 1.1. Cookiecutter Parameters

* `dataset_name`: dataset nname

* `author`: dataset's primary author (or maintainer)

* `email`: : primary author's (or maintainer's) email

* `dataset_license`: type of license to use for the dataset

* `software_license`: type of license to use for supporting software

* `python_version`: Python versions compatible with project. See the
  "[Dependency sepcification][poetry-dependency-specification]" section
  of the Poetry documentation for version specifier semantics.

### 1.2. Setting Up a New Dataset

1. ___Prerequisites___

   * Install [Git][git].

   * Install [Python][python] 3.9 (or greater).

   * Install [Poetry][poetry] 1.2 (or greater).

     __Note__. The dataset template uses `poetry` instead of `pip` for
     management of Python package dependencies.

   * Install the [Cookiecutter][cookiecutter] Python package.

   * _Optional_. Install [direnv][direnv].

2. Use `cookiecutter` to create a new Python project.

   ```shell
   $ cookiecutter https://github.com/velexi-research/VLXI-Cookiecutter-Dataset.git
   ```

3. Set up dedicated virtual environment for the project. Any of the common
   virtual environment options (e.g., `venv`, `direnv`, `conda`) should work.
   Below are instructions for setting up a `direnv` or `poetry` environment.

   __Note__: to avoid conflicts between virtual environments, only one method
   should be used to manage the virtual environment.

   * __`direnv` Environment__. __Note__: `direnv` manages the environment for
     both Python and the shell.

     * ___Prerequisite___. Install `direnv`.

     * Copy `extras/dot-envrc` to the project root directory, and rename it to
       `.envrc`.

       ```shell
       $ cd $PROJECT_ROOT_DIR
       $ cp extras/dot-envrc .envrc
       ```

     * Grant permission to direnv to execute the .envrc file.

       ```shell
       $ direnv allow
       ```

   * __`poetry` Environment__. __Note__: `poetry` only manages the Python
     environment (it does not manage the shell environment).

     * Create a `poetry` environment that uses a specific Python executable.
       For instance, if `python3` is on your `PATH`, the following command
       creates (or activates if it already exists) a Python virtual environment
       that uses `python3` for the project.

       ```shell
       $ poetry env use python3
       ```

       For commands to use other Python executables for the virtual environment,
       see the [Poetry Quick Reference][poetry-quick-reference].

4. Install the Python package dependencies (e.g., pre-commit, DVC, FastDS).

   ```shell
   $ poetry install
   ```

5. Configure Git.

   * Install the git pre-commit hooks.

     ```shell
     $ pre-commit install
     ```

   * _Optional_. Set up a remote Git repository (e.g., GitHub repository).

     * Create a remote Git repository.

     * Configure the remote Git repository.

       ```shell
       $ git remote add origin GIT_REMOTE
       ```

       where `GIT_REMOTE` is the URL of the remote Git repository.

     * Push the `main` branch to the remote Git repository.

       ```shell
       $ git checkout main
       $ git push -u origin main
       ```

6. _Optional_ Configure remote storage for DVC (e.g., an AWS S3 bucket).

   * Create remote storage for the dataset. Below are instructions for setting
     up a storage on the local file system or AWS S3.

     * __Local File System__. Create a directory that DVC can use to store a
       copy of the dataset (outside of the working dataset directory).

     * __AWS S3__. Create an S3 bucket that DVC can use for remote storage.

   * Configure the remote DVC storage for the dataset.

     ```shell
     $ dvc remote add -d storage DVC_REMOTE
     $ fds commit "Add DVC remote storage."
     ```

     where `DVC_REMOTE` is the URL of the remote storage for the dataset
     (e.g., the path to a directory on the local file system or the URL to
     the S3 bucket). __Note__: if desired, the name "storage" can be
     replaced by a different name.

7. Finish setting up the new dataset.

   * Verify the copyright year and owner in the copyright notice.

     __Note__. If the software is licensed under Apache License 2.0, the
     software copyright notice is located in the `NOTICE` file. Otherwise,
     the software copyright notice is located in the `LICENSE` file.

   * Update the Python package dependencies to the latest available
     versions.

     ```shell
     $ poetry update
     ```

   * Customize the `README.md` file to reflect the specifics of the dataset.

   * Commit all updated files (e.g., `poetry.lock`) to the dataset Git
     repository.

------------------------------------------------------------------------------

## 2. Contributor Notes

### 2.1. License

The contents of this cookiecutter are covered under the Apache License 2.0
(included in the `LICENSE` file). The copyright for this cookiecutter is
contained in the `NOTICE` file.

### 2.2. Repository Contents

```
├── README.md               <- this file
├── RELEASE-NOTES.md        <- cookiecutter release notes
├── LICENSE                 <- cookiecutter license
├── NOTICE                  <- cookiecutter copyright notice
├── cookiecutter.json       <- cookiecutter configuration file
├── pyproject.toml          <- Python project metadata file for cookiecutter
│                              development
├── poetry.lock             <- Poetry lockfile
├── docs/                   <- cookiecutter documentation
├── extras/                 <- additional files that may be useful for
│                              cookiecutter development
├── hooks/                  <- cookiecutter scripts that run before and/or
│                              after project generation
├── spikes/                 <- experimental code
└── {{cookiecutter.name}}/  <- cookiecutter template
```

### 2.3. Software Requirements

#### Base Requirements

* [Git][git]
* [Python][python] (>=3.7.2)
* [Poetry][poetry]

#### Optional Packages

* [direnv][direnv]

#### Python Packages

See `[tool.poetry.dependencies]` section of [`pyproject.toml`](pyproject.toml).

### 2.4. Setting Up to Develop the Cookiecutter

1. Set up a dedicated virtual environment for cookiecutter development.
   See Step 3 from [Section 2.1][#2.1] for instructions on how to set up
   `direnv` and `poetry` environments.

2. Install the Python packages required for development.

   ```shell
   $ poetry install

3. Install the git pre-commit hooks.

   ```shell
   $ pre-commit install
   ```

4. Make the cookiecutter better!

### 2.5. Additional Notes

#### Updating Cookiecutter Template Dependencies

To update the Python dependencies for the template (contained in the
`{{cookiecutter.dataset_name}}` directory), use the following procedure to
ensure that package dependencies for developing the non-template components
of the cookiecutter do not interfere with package dependencies for the
template.

* Create a local clone of the cookiecutter Git repository to use for
  cookiecutter development.

  ```shell
  $ git clone git@github.com:velexi-research/VLXI-Cookiecutter-Dataset.git
  ```

* Use `cookiecutter` from the local cookiecutter Git repository to create a
  clean project for template dependency updates.

  ```shell
  $ cookiecutter PATH/TO/LOCAL/REPO
  ```

* In the pristine project, perform the following steps to update the template's
  package dependencies.

  * Set up a virtual environment for developing the template (e.g., a direnv
    environment).

  * Use `poetry` or manually edit `pyproject.toml` to (1) make changes to the
    package dependency list and (2) update the package dependency versions.

  * Use `poetry` to update the package dependencies and versions recorded in
    the `poetry.lock` file.

* Update `{{cookiecutter.dataset_name}}/pyproject.toml`.

  * Copy `pyproject.toml` from the pristine project to
    `{{cookiecutter.dataset_name}}/pyproject.toml`.

  * Restore the templated values in the `[tool.poetry]` section to the
    following:

    <!-- {% raw %} -->
    ```jinja
    [tool.poetry]
    name = "{{ cookiecutter.dataset_name }}"
    version = "0.1.0"
    description = ""
    license = "{% if cookiecutter.license == 'Apache License 2.0' %}Apache-2.0{% elif cookiecutter.license == 'BSD-3-Clause License' %}BSD-3-Clause{% elif cookiecutter.license == 'MIT License' %}MIT{% endif %}"
    readme = "README.md"
    authors = ["{{ cookiecutter.author }} <{{ cookiecutter.email }}>"]
    ```
    <!-- {% endraw %} -->

* Update `{{cookiecutter.dataset_name}}/poetry.lock`.

  * Copy `poetry.lock` from the pristine project to
    `{{cookiecutter.dataset_name}}/poetry.lock`.

* Commit the updated `pyproject.toml` and `poetry.lock` files to the Git
  repository.

------------------------------------------------------------------------------

## 3. Documentation

* [Poetry Quick Reference][poetry-quick-reference]

------------------------------------------------------------------------------

[-----------------------------INTERNAL LINKS-----------------------------]: #

[#1]: #1-usage
[#1.1]: #11-cookiecutter-parameters
[#1.2]: #12-setting-up-a-new-dataset

[#2]: #2-contributor-notes
[#2.1]: #21-license
[#2.2]: #22-repository-contents
[#2.3]: #23-software-requirements
[#2.4]: #24-setting-up-to-develop-the-cookiecutter
[#2.5]: #25-additional-notes

[#3]: #3-documentation

[---------------------------- REPOSITORY LINKS ----------------------------]: #

[poetry-quick-reference]: {{cookiecutter.dataset_name}}/extras/references/Poetry-Quick-Reference.md

[vlxi-cookiecutter-dataset]: https://github.com/velexi-research/VLXI-Cookiecutter-Dataset

[-----------------------------EXTERNAL LINKS-----------------------------]: #

[cookiecutter]: https://cookiecutter.readthedocs.io/en/latest/

[direnv]: https://direnv.net/

[fastds]: https://github.com/DAGsHub/fds

[git]: https://git-scm.com/

[poetry]: https://python-poetry.org/

[poetry-dependency-specification]: https://python-poetry.org/docs/dependency-specification/

[pre-commit]: https://pre-commit.com/

[python]: https://www.python.org/
