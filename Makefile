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

# Docker Compose Variables
DOCKER_COMPOSE = docker compose
API_CONTAINER = flask-container
DB_CONTAINER = postgres-container

# Local commands

.DEFAULT_GOAL := help

help:
	@echo "Available commands:"
	@echo "make install       Install dependencies from requirements.txt"
	@echo "make freeze        Freeze dependencies to requirements.txt"
	@echo "make run           Run the Flask app"
	@echo "make test          Run unit tests with pytest"
	@echo "make clean         Remove Python cache and pytest cache"

	@echo "make docker-build  Build the Docker image"
	@echo "make docker-run    Run the Docker container"
	@echo "make docker-stop   Stop and remove the Docker container"
	@echo "make docker-logs   View logs of the Docker container"
	@echo "make docker-clean  Remove the Docker image"
	
	@echo "make db            Start only the Postgres DB service"
	@echo "make migrate       Run DB migrations (upgrade schema)"
	@echo "make seed          Seed dummy data into DB"
	@echo "make build         Build the API Docker image"
	@echo "make run           Run the API container (depends on DB + migrations + seed)"
	@echo "make up            Start all services (DB + API)"
	@echo "make down          Stop all services and remove volumes"	


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
	docker build -f app/Dockerfile -t $(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG) .

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

# Docker Compose commands

# Start only DB service
db:
	$(DOCKER_COMPOSE) up -d postgres

# Run DB migrations (upgrade schema)
migrate:
	docker exec -it $(API_CONTAINER) flask db upgrade

# Seed dummy data into DB
seed:
	docker exec -it $(API_CONTAINER) python seed.py

# Build API image
build:
	$(DOCKER_COMPOSE) build flask-backend

# Run API container (depends on DB + migrations + seed)
run: up migrate seed
	@echo "API and DB are up and running with schema + seed data."

# Start all services (DB + API)
up:
	$(DOCKER_COMPOSE) up -d

# Stop all services and remove volumes
down:
	$(DOCKER_COMPOSE) down -v
