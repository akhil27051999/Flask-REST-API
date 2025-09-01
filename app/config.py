import os
from dotenv import load_dotenv
# This file is used to configure the application settings
# Load environment variables from a .env file
load_dotenv()

class Config:
    DEBUG = os.getenv('DEBUG', 'False') == 'True'

    # postgresql settings
    POSTGRES_USER = os.getenv('POSTGRES_USER', 'user')
    POSTGRES_PASSWORD = os.getenv('POSTGRES_PASSWORD', 'password')
    POSTGRES_HOST = os.getenv('POSTGRES_HOST', 'postgres')
    POSTGRES_DB = os.getenv('POSTGRES_DB', 'dbname')
    POSTGRES_PORT = os.getenv('POSTGRES_PORT', '5432')

    SQLALCHEMY_DATABASE_URI = f"postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}:{POSTGRES_PORT}/{POSTGRES_DB}"
    SQLALCHEMY_TRACK_MODIFICATIONS = False  # always good to disable

   