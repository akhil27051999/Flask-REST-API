# Makefile for Flask REST API project

# Local Variables
PYTHON = python
PIP = pip
PYTEST = pytest
FLASK_APP = app
REQ = requirements.txt

# Docker Variables
DOCKER_IMAGE = flask-app
DOCKER_IMAGE_TAG ?= 1.0.0
DOCKER_CONTAINER = flask-container

# Docker Compose Variables
DOCKER_COMPOSE = docker compose
API_CONTAINER = flask-container
DB_CONTAINER = postgres-container

# Default Goal
.DEFAULT_GOAL := help

help:
	@echo "Available commands:"
	@echo "make install        Install dependencies from requirements.txt"
	@echo "make freeze         Freeze dependencies to requirements.txt"
	@echo "make lint           Run linting on Python code"
	@echo "make run            Run Flask app locally"
	@echo "make test           Run unit tests with pytest"
	@echo "make clean          Remove Python cache and pytest cache"
	@echo "make docker-build   Build the Docker image"
	@echo "make docker-run     Run the Docker container"
	@echo "make docker-stop    Stop and remove the Docker container"
	@echo "make docker-logs    View logs of the Docker container"
	@echo "make docker-clean   Remove the Docker image"
	@echo "make docker-push    Push Docker image to Docker Hub"
	@echo "make db             Start only the Postgres DB service"
	@echo "make migrate        Run DB migrations (upgrade schema)"
	@echo "make seed           Seed dummy data into DB"
	@echo "make compose-build  Build the API Docker image via Compose"
	@echo "make compose-up     Start all services (DB + API)"
	@echo "make compose-down   Stop all services and remove volumes"

# Local commands
install:
	$(PIP) install -r $(REQ)

freeze:
	$(PIP) freeze > $(REQ)

lint:
	pylint app tests || true

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

docker-push:
	docker tag $(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG) $(DOCKER_HUB_USERNAME)/$(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG)
	docker push $(DOCKER_HUB_USERNAME)/$(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG)

# Docker Compose commands
db:
	$(DOCKER_COMPOSE) up -d $(DB_CONTAINER)

migrate:
	docker exec -it $(API_CONTAINER) flask db upgrade

seed:
	docker exec -it $(API_CONTAINER) python seed.py

compose-build:
	$(DOCKER_COMPOSE) build flask-backend

compose-up:
	$(DOCKER_COMPOSE) up -d

compose-down:
	$(DOCKER_COMPOSE) down -v

.PHONY: help install freeze lint run test clean docker-build docker-run docker-stop docker-logs docker-clean docker-push db migrate seed compose-build compose-up compose-down
