import pytest
import os
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))

from app import create_app, db
from tests.config import TestConfig

@pytest.fixture
def client():
    # Create the app with TestConfig
    app = create_app(config_class=TestConfig)

    # Setup DB
    with app.app_context():
        db.create_all()

    # Provide a test client
    with app.test_client() as client:
        yield client

    # Cleanup DB after test
    with app.app_context():
        db.drop_all()
