from . import db   # 👈 import db from __init__.py, not re-create it

class Student(db.Model):
    __tablename__ = "students"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    domain = db.Column(db.String(50), nullable=False)
    gpa = db.Column(db.Float, nullable=False)
