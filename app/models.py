from . import db   # Import db from the app package

class Student(db.Model):
    __tablename__ = "students"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    domain = db.Column(db.String(50), nullable=False)
    gpa = db.Column(db.Float, nullable=False)
