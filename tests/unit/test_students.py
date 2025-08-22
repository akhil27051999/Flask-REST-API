def test_healthcheck(client):
    res = client.get("/health")
    assert res.status_code == 200
    assert res.get_json() == {"status": "ok"}


def test_add_student(client):
    student_data = {
        "name": "Ramesh Kumar",
        "domain": "ECE",
        "gpa": 8.7,
        "email": "160101130001@cutm.ac.in"
    }
    res = client.post("/students", json=student_data)
    assert res.status_code == 201
    assert res.get_json()["message"] == "Student added successfully!"


def test_get_students(client):
    res = client.get("/students")
    assert res.status_code == 200
    assert isinstance(res.get_json(), list)


def test_get_student_by_id(client):
    # Add a student first
    student_data = {
        "name": "Sita Devi",
        "domain": "ECE",
        "gpa": 9.1,
        "email": "160101130002@cutm.ac.in"
    }
    add_res = client.post("/students", json=student_data)
    assert add_res.status_code == 201

    # Now fetch by ID
    res = client.get("/students/1")
    assert res.status_code == 200
    data = res.get_json()
    assert data["name"] == "Sita Devi"
    assert data["domain"] == "ECE"


def test_update_student(client):
    # Add a student first
    student_data = {
        "name": "Amit Sharma",
        "domain": "ECE",
        "gpa": 7.9,
        "email": "160101130003@cutm.ac.in"
    }
    client.post("/students", json=student_data)

    # Update student
    update_data = {"gpa": 9.0}
    res = client.put("/students/1", json=update_data)
    assert res.status_code == 200
    assert res.get_json()["message"] == "Student updated successfully!"


def test_delete_student(client):
    # Add a student first
    student_data = {
        "name": "Priya Singh",
        "domain": "ECE",
        "gpa": 8.5,
        "email": "160101130004@cutm.ac.in"
    }
    client.post("/students", json=student_data)

    # Delete student
    res = client.delete("/students/1")
    assert res.status_code == 200
    assert res.get_json()["message"] == "Student deleted successfully!"
