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

- Create a project folder and a .venv folder within:
  ```bash
  mkdir myproject && cd myproject
  ```

- Install python3-venv:
  ```bash
  sudo apt update
  sudo apt install python3-venv python3-pip
  ```

- Create a new virtual environment:
  ```bash
  python3 -m venv venv
  ```

- Activate the environment :
  ```bash
  source venv/bin/activate
  ```  

- Verify Python and pip installation:
  ```bash
  python3 --version
  pip --version
  ```

- Within the activated environment, use the following command to install tools:
  ```bash
  pip install Flask Flask-SQLAlchemy Flask-Migrate python-dotenv pytest
  ```  

- To verify and list the installations :
  ```bash
  python3 --version && pip list
  ```

- copy the dependencies to requirements.txt :
  ```bash
  pip freeze > requirements.txt
  ```

## Project Local Setup

- Install dependencies
  ```
  make install
  ```
  - (or run pip install -r requirements.txt directly)

- Run the App
  ```
  make run
  ```

- Flask app will start at:
  ```url
  http://127.0.0.1:5000
  ```

  - Endpoints:
    - / → Welcome message
    - /health → Health check
    - /students → Manage students
      
- Run all unit tests:
  ```
  make test
  ```
  Or directly:

  ```
  pytest -v
  ```
