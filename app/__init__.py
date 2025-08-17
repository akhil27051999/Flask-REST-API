from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

db = SQLAlchemy()
migrate = Migrate()

def create_app():
    app = Flask(__name__)
    app.config["SQLALCHEMY_DATABASE_URI"] = "postgresql://<username>:<password>@<host>/<dbname>"
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False  # always good to disable

    # Initialize extensions
    db.init_app(app)
    migrate.init_app(app, db)

    from . import models


    return app

