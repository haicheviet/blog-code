#!/usr/bin/env bash

set -e

black --check app 
isort --check-only app
flake8 app
mypy app
