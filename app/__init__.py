from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

db = SQLAlchemy()
migrate = Migrate()

def create_app():
    app = Flask(__name__)
    app.config.from_object('app.config.Config') # Load configuration from Config class

    db.init_app(app)
    migrate.init_app(app, db)

    with app.app_context():
        from . import models
       # db.create_all()  # Create database tables if they don't exist
        
    return app