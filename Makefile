# Makefile for Flask REST API project

# Local Variables

PYTHON=python
PIP=pip
PYTEST=pytest
FLASK_APP=app
VENV=venv
REQ=requirements.txt

# Docker Variables
DOCKER_IMAGE=multi-stage-app
DOCKER_IMAGE_TAG ?= 1.0.0
DOCKER_CONTAINER=myapp-container

# Local commands

.DEFAULT_GOAL := help

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

# Docker commands

docker-build:
	docker build -t $(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG) .

docker-run:
	docker run -d -p 5000:5000 --name $(DOCKER_CONTAINER) $(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG)

docker-stop:
	docker stop $(DOCKER_CONTAINER) || true
	docker rm $(DOCKER_CONTAINER) || true

docker-logs:
	docker logs -f $(DOCKER_CONTAINER)

docker-clean:
	docker rmi $(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG) || true

.PHONY: help install freeze run test clean docker-build docker-run docker-stop docker-logs docker-clean

