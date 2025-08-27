# Simple REST API Webserver

### Overview: 
**Created a Student CRUD REST API using python programming language and Flask web framework.
With this we can able to:**
- `Create`: Add a new student.
- `Read` (All): Retrieve a list of all students.
- `Read` (One): Retrieve details of a specific student by ID.
- `Update`: Modify existing student information.
- `Delete`: Remove a student record by ID.

## Purpose of the Repo

**The following RESTful design principles and standards were implemented with the help of `Twelve Factor App` and `Best Practices for REST API Design`**

- **Versioning:**

  All endpoints are versioned:
    e.g., /api/v1/students

- **HTTP Methods Used Correctly:**
  - POST – Create a new student
  - GET – Fetch student(s)
  - PUT – Update student information
  - DELETE – Remove a student

- **Logging:**

  Meaningful and structured logs are emitted with appropriate log levels (INFO, WARNING, ERROR).

- **Health Check Endpoint:**

  A dedicated /api/v1/healthcheck endpoint is available to verify the API's availability and status.

- **Unit Testing:**

  Each endpoint is covered by unit tests to ensure proper functionality and error handling.


## Project Prerequisites

- **Create a project folder and a .venv folder within:**
  ```sh
  mkdir myproject && cd myproject
  ```

- **Install python3-venv:**
  ```sh
  sudo apt update
  sudo apt install python3-venv python3-pip
  ```

- **Create a new virtual environment:**
  ```sh
  python3 -m venv venv
  ```

- **Activate the environment :**
  ```sh
  source venv/bin/activate
  ```  

- **Verify Python and pip installation:**
  ```sh
  python3 --version
  pip --version
  ```

- **Within the activated environment, use the following command to install tools:**
  ```sh
  pip install Flask Flask-SQLAlchemy Flask-Migrate python-dotenv pytest
  ```  

- **To verify and list the installations :**
  ```sh
  python3 --version && pip list
  ```

- **copy the dependencies to requirements.txt :**
  ```sh
  pip freeze > requirements.txt
  ```

## Project Local Setup

- **Install dependencies**
  ```txt
  make install
  ```
  - (or run pip install -r requirements.txt directly)

- **Run the App**
  ```txt
  make run
  ```

- **Flask app will start at:**
  ```url
  http://127.0.0.1:5000
  ```

  - Endpoints:
    - / → Welcome message
    - /health → Health check
    - /students → Manage students
      
- **Run all unit tests:**
  ```txt
  make test
  ```
  Or directly:

  ```txt
  pytest -v
  ```

## Containerising the REST API

**Containerised REST API with the Docker best practices and reduced both Size and Build Time of my Docker Image:**
  - Used `python:3.10-alpine` for base image which resulted in reducing the image size because of it's lightweight version that supports the build process without impacting it's functionality. as a resultant the application image size reduced from `1.26GB` to `176MB`.

  - Followed Multi-stage Dockerfile method, this helped to reduce the image size from `176MB` to `110MB`, This approach ensures that only the essential runtime files are included in the final image, reducing size and improving performance.

  - Overall I managed to reduce the original `1.26GB` image to just `110MB`, achieving a `91.27%` size decrease while maintaining the same functionality and improving rebuild times by an average of 20 seconds.

### Docker Commands

- **Build the Docker Image:**
  - Built the image with semantic versioning tags:
  ```sh
  make docker-build DOCKER_IMAGE_TAG=1.0.1
  ```

  or directly with Docker:
  ```sh
  docker build -f app/Dockerfile -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .
  ```
  - We can change the `DOCKER_IMAGE_TAG` to any version.

- **Run the Docker Container:**
  - Run the container 
  ```sh
  make docker-run DOCKER_IMAGE_TAG=1.0.1
  ```
  or directly with Docker:

  ```sh
  docker run -d --env-file .env -p 5000:5000 ${DOCKER_CONTAINER} ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
  ```
  - Now the API will be available at:
  ```url
  http://localhost:5000
  ```

- **To Remove the Containers:**
  - To remove the containers using make command
  ```sh
  make docker-stop
  ```

  or directly with Docker:

  ```sh 
  docker stop ${DOCKER_CONTAINER}
  docker rm ${DOCKER_CONTAINER}
  ```

- **To Remove the unused images:**
  - To remove the images using make command
  ```sh
  make docker-clean
  ```

  or directly with Docker:

  ```sh
  docker rmi ${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG}
  ```

-  **For Troubleshooting Container issue:**
  - To check container logs using make command
  ```sh
  make docker logs
  ```

  or directly with Docker:

  ```sh
  docker logs -f ${DOCKER_CONTAINER}
  ```
  
