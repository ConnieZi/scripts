#!/bin/bash

# Make sure you are in the project root directory

# Check if pyenv is already installed
if command -v pyenv &> /dev/null; then
    echo "pyenv is already installed."
else
    curl https://pyenv.run | bash
    # setup zsh env variables
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
fi

# install Build dependencies
brew install openssl readline sqlite3 xz zlib tcl-tk

# install a specfic python version with pyenv
pyenv install 3.10.6

# Check if Poetry is already installed
if command -v poetry &> /dev/null; then
    echo "Poetry is already installed."
else
    # Download and install Poetry
    echo "Downloading and installing Poetry..."
    curl -sSL https://install.python-poetry.org | python3

    # Add Poetry to the system's PATH
    echo "Adding Poetry to the system's PATH..."
    source $HOME/.poetry/env

    # Verify installation
    if command -v poetry &> /dev/null; then
        echo "Poetry installation successful!"
    else
        echo "Poetry installation failed."
    fi
fi

# Check if pyproject.toml file exists
if [ -f "pyproject.toml" ]; then
    echo "pyproject.toml exists."
else
    echo "pyproject.toml does not exist."
    exit 0
fi

# Check if poetry.lock file exists
if [ -f "poetry.lock" ]; then
    echo "poetry.lock exists."
else
    echo "poetry.lock does not exist."
    exit 0
fi

# Create a virtual environment with poetry under the root directory
poetry config virtualenvs.create true --local
poetry install

# activate the venv
source .venv/bin/activate