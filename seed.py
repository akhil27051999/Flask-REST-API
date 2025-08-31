from app import create_app, db
from app.models import Student

app = create_app()

with app.app_context():
    # Dummy students
    students = [
        Student(name="Akhil Thyadi", domain="Electronics", gpa=7.01, email="160101130028@cutm.ac.in"),
        Student(name="Anudeep Sistu", domain="Electronics", gpa=7.8, email="160101130046@cutm.ac.in"),
        Student(name="Atchyuth Teki", domain="Electronics", gpa=7.5, email="160101130038@cutm.ac.in"),
    ]

    db.session.bulk_save_objects(students)
    db.session.commit()
    print("Dummy data inserted successfully!")