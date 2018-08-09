.PHONY: env run 
.DEFAULT: env

SHELL := /bin/bash

env: 
	@echo "Building the python environment..."
	@pipenv install 
	

run:
	@pipenv run python main.py
