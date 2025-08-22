import os
from dotenv import load_dotenv

# Load .env.test
load_dotenv(dotenv_path=".env.test")

class TestConfig:
    DEBUG = os.getenv("DEBUG", "False") == "True"

    # Use SQLite in-memory DB for testing
    SQLALCHEMY_DATABASE_URI = "sqlite:///:memory:"
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Logging
    LOG_FILE = os.getenv("LOG_FILE", "test.log")
