#!/bin/bash

VENV_DIR="venv"
REQUIRED_LIBS="mysql-connector-python prettytable"

if [ ! -d "$VENV_DIR" ]; then
    echo "Virtual environment not found. Creating a new one..."
    python3 -m venv "$VENV_DIR"
    echo "Virtual environment created."
else
    echo "Virtual environment already exists."
fi

source "$VENV_DIR/bin/activate"
pip install --upgrade pip
pip install $REQUIRED_LIBS

echo "Libraries installed and virtual environment setup complete."
