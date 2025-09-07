from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from .logger import setup_logger

db = SQLAlchemy()
migrate = Migrate()

def create_app(config_class=None):
    app = Flask(__name__)

    # Configure the app
    if config_class:
        app.config.from_object(config_class)
    else:
        app.config.from_object('app.config.Config')


    # Initialize logger
    logger = setup_logger('student_logger', log_file='app.log')
    app.logger.info("Student Management API started successfully.")

    # Initialize database and migration
    db.init_app(app)
    migrate.init_app(app, db)

    # Import models inside app context
    with app.app_context():
        from . import models

    # Import and register blueprints here (after db/models are ready)
    from .routes import student_bp
    app.register_blueprint(student_bp, url_prefix='/students')

    # Home route
    @app.route('/')
    def home():
        app.logger.info("Home page accessed")
        return "Welcome to the Student Management API!"

    # Health check route
    @app.route('/health')
    def health():
        app.logger.info("Health check accessed")
        return jsonify({"status": "ok"}), 200

    return app