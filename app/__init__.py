from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

db = SQLAlchemy()
migrate = Migrate()

def create_app():
    app = Flask(__name__)
    
    # Configure the app with database URI and other settings
    app.config.from_object('app.config.Config')
    
    # Initialize the database and migration tools
    db.init_app(app)
    migrate.init_app(app, db)
    
    # Initialize the database models
    with app.app_context():
        from . import models

    # Register the student blueprint  
    from .routes import student_bp
    app.register_blueprint(student_bp, url_prefix='/students')

    # Register the home route
    @app.route('/')
    def home():
        return "Welcome to the Student Management API!"

    return app