# Makefile for Flask REST API project

# Variables

PYTHON=python
PIP=pip
PYTEST=pytest
FLASK_APP=app
VENV=venv
REQ=requirements.txt


help:
	@echo "Available commands:"
	@echo "make install       Install dependencies from requirements.txt"
	@echo "make freeze        Freeze dependencies to requirements.txt"
	@echo "make run           Run the Flask app"
	@echo "make test          Run unit tests with pytest"
	@echo "make clean         Remove Python cache and pytest cache"

install:
	$(PIP) install -r $(REQ)

freeze:
	$(PIP) freeze > $(REQ)

run:
	FLASK_APP=$(FLASK_APP) flask run --host=0.0.0.0 --port=5000

test:
	$(PYTEST) -v 

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	rm -rf .pytest_cache
