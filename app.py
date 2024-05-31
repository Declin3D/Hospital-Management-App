# app.py

from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from datetime import datetime
import random
from random import sample, choice
import mysql.connector
import matplotlib.pyplot as plt
import io
import base64
from sqlalchemy.sql import func
from decimal import Decimal


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/asylum'
app.config['SECRET_KEY'] = 'your_secret_key'
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)



class Admin(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(150), nullable=False, unique=True)
    password = db.Column(db.String(150), nullable=False)

class Staff(db.Model):
    __tablename__ = 'staff'
    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50))
    last_name = db.Column(db.String(50))
    position = db.Column(db.String(50))
    pay = db.Column(db.Numeric(10, 2), nullable=False)
class Doctor(db.Model):
    __tablename__ = 'doctors'
    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    specialization = db.Column(db.String(100), nullable=False)
    pay = db.Column(db.Numeric(10, 2), nullable=False)
    position = db.Column(db.String(150), nullable=False)
    patients_served = db.Column(db.Integer, default=0)
    success_rate = db.Column(db.Float, default=0.0)
    schedules = db.relationship('DoctorSchedule', backref='doctor', lazy=True)

class Patient(db.Model):
    __tablename__ = 'patients'
    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    disease = db.Column(db.String(100), nullable=False)
    checked_in = db.Column(db.Date, default=False)
    medical_history = db.Column(db.Text, nullable=True)
    schedules = db.relationship('PatientSchedule', backref='patient', lazy=True)

class DoctorSchedule(db.Model):
    __tablename__ = 'doctor_schedule'
    id = db.Column(db.Integer, primary_key=True)
    doctor_id = db.Column(db.Integer, db.ForeignKey('doctors.id'), nullable=False)
    work_day = db.Column(db.String(50), nullable=False)
    start_time = db.Column(db.Time, nullable=False)
    end_time = db.Column(db.Time, nullable=False)

class PatientSchedule(db.Model):
    __tablename__ = 'patient_schedule'
    id = db.Column(db.Integer, primary_key=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.id'), nullable=False)
    appointment_day = db.Column(db.Date, nullable=False)
    appointment_time = db.Column(db.Time, nullable=False)
    doctor_id = db.Column(db.Integer, db.ForeignKey('doctors.id'), nullable=False)



class Resource(db.Model):
    __tablename__ = 'resources'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    threshold = db.Column(db.Integer, nullable=False)
    price = db.Column(db.Numeric(7,2), nullable=False)

class Finance(db.Model):
    __tablename__ = 'finances'
    id = db.Column(db.Integer, primary_key=True)
    month = db.Column(db.String(50), nullable=False)
    budget = db.Column(db.Numeric(10, 2), nullable=False)
    expenses = db.Column(db.Numeric(10, 2), nullable=False, default=0.00)

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
        new_admin = Admin(username=username, password=hashed_password)
        db.session.add(new_admin)
        db.session.commit()
        flash('Admin registered successfully', 'success')
        return redirect(url_for('login'))
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        admin = Admin.query.filter_by(username=username).first()
        if admin and bcrypt.check_password_hash(admin.password, password):
            session['admin_id'] = admin.id
            session['username'] = admin.username
            return redirect(url_for('dashboard'))
        else:
            flash('Login Unsuccessful. Please check username and password', 'danger')
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.pop('admin_id', None)
    session.pop('username', None)
    flash('You have been logged out', 'success')
    return redirect(url_for('login'))

@app.route('/dashboard')
def dashboard():
    num_patients = Patient.query.count()
    num_doctors = Doctor.query.count()
    num_staff = Staff.query.count()

    upcoming_appointments = PatientSchedule.query.filter(PatientSchedule.appointment_day >= datetime.now()).order_by(PatientSchedule.appointment_day).limit(5).all()
    upcoming_shifts = DoctorSchedule.query.filter(DoctorSchedule.start_time >= datetime.now()).order_by(DoctorSchedule.start_time).limit(5).all()
    recent_activities = ["Patient John Doe admitted", "Dr. Smith performed surgery", "New staff member added"]

    return render_template('dashboard.html', num_patients=num_patients, num_doctors=num_doctors, num_staff=num_staff,
                           upcoming_appointments=upcoming_appointments, upcoming_shifts=upcoming_shifts,
                           recent_activities=recent_activities)

@app.route('/patients')
def patients():
    patients = Patient.query.all()
    return render_template('patients.html', patients=patients)

@app.route('/medical_history/<int:patient_id>')
def medical_history(patient_id):
    patient = Patient.query.get_or_404(patient_id)
    return render_template('medical_history.html', patient=patient)

@app.route('/release_patient/<int:patient_id>')
def release_patient(patient_id):
    patient = Patient.query.get_or_404(patient_id)
    db.session.delete(patient)
    db.session.commit()
    flash('Patient released successfully', 'success')
    return redirect(url_for('patients'))

@app.route('/register_patient', methods=['GET', 'POST'])
def register_patient():
    if request.method == 'POST':
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        admission_date = func.current_date()
        disease = request.form['disease']
        medical_history = request.form['medical_history']

        new_patient = Patient(
            first_name=first_name,
            last_name=last_name,
            checked_in=admission_date,
            disease=disease,
            medical_history=medical_history
        )
        db.session.add(new_patient)
        db.session.commit()
        flash('Patient registered successfully', 'success')
        return redirect(url_for('patients'))

    return render_template('register_patient.html')

@app.route('/doctors')
def doctors():
    doctors = Doctor.query.all()
    return render_template('doctors.html', doctors=doctors)

@app.route('/promote_doctor/<int:doctor_id>', methods=['GET', 'POST'])
def promote_doctor(doctor_id):
    doctor = Doctor.query.get_or_404(doctor_id)
    if request.method == 'POST':
        doctor.position = request.form['position']
        doctor.pay = request.form['pay']
        db.session.commit()
        flash('Doctor promoted successfully', 'success')
        return redirect(url_for('doctors'))
    return render_template('promote_doctor.html', doctor=doctor)

@app.route('/fire_doctor/<int:doctor_id>')
def fire_doctor(doctor_id):
    doctor = Doctor.query.get_or_404(doctor_id)
    db.session.delete(doctor)
    db.session.commit()
    flash('Doctor fired successfully', 'success')
    return redirect(url_for('doctors'))

@app.route('/staff')
def staff():
    staff_members = Staff.query.all()
    return render_template('staff.html', staff=staff_members)

@app.route('/promote_staff/<int:staff_id>', methods=['GET', 'POST'])
def promote_staff(staff_id):
    staff_member = Staff.query.get_or_404(staff_id)
    if request.method == 'POST':
        staff_member.position = request.form['position']
        staff_member.pay = request.form['pay']
        db.session.commit()
        flash('Staff promoted successfully', 'success')
        return redirect(url_for('staff'))
    return render_template('promote_staff.html', staff=staff_member)

@app.route('/fire_staff/<int:staff_id>')
def fire_staff(staff_id):
    staff_member = Staff.query.get_or_404(staff_id)
    db.session.delete(staff_member)
    db.session.commit()
    flash('Staff fired successfully', 'success')
    return redirect(url_for('staff'))



specializations = [
    'Allergy and immunology', 'Anesthesiology', 'Dermatology', 'Diagnostic radiology',
    'Emergency medicine', 'Family medicine', 'Internal medicine', 'Medical genetics',
    'Neurology', 'Nuclear medicine', 'Obstetrics and gynecology', 'Ophthalmology',
    'Pathology', 'Pediatrics', 'Physical medicine and rehabilitation', 'Preventive medicine',
    'Psychiatry', 'Radiation oncology', 'Surgery', 'Urology'
]
names = [
    "Olivia", "Emma", "Charlotte", "Amelia", "Sophia", "Isabella", "Ava", "Mia", "Evelyn", "Luna",
    "Harper", "Camila", "Sofia", "Scarlett", "Elizabeth", "Eleanor", "Emily", "Chloe", "Mila", "Violet",
    "Penelope", "Gianna", "Aria", "Abigail", "Ella", "Avery", "Hazel", "Nora", "Layla", "Lily",
    "Aurora", "Nova", "Ellie", "Madison", "Grace", "Isla", "Willow", "Zoe", "Riley", "Stella",
    "Eliana", "Ivy", "Victoria", "Emilia", "Zoey", "Naomi", "Hannah", "Lucy", "Elena", "Lillian",
    "Maya", "Leah", "Paisley", "Addison", "Natalie", "Valentina", "Everly", "Delilah", "Leilani", "Madelyn",
    "Kinsley", "Ruby", "Sophie", "Alice", "Genesis", "Claire", "Audrey", "Sadie", "Aaliyah", "Josephine",
    "Autumn", "Brooklyn", "Quinn", "Kennedy", "Cora", "Savannah", "Caroline", "Athena", "Natalia", "Hailey",
    "Aubrey", "Emery", "Anna", "Iris", "Bella", "Eloise", "Skylar", "Jade", "Gabriella", "Ariana",
    "Maria", "Adeline", "Lydia", "Sarah", "Nevaeh", "Serenity", "Liliana", "Ayla", "Everleigh", "Raelynn",
    "Liam", "Noah", "Oliver", "James", "Elijah", "William", "Henry", "Lucas", "Benjamin", "Theodore",
    "Mateo", "Levi", "Sebastian", "Daniel", "Jack", "Michael", "Alexander", "Owen", "Asher", "Samuel",
    "Ethan", "Leo", "Jackson", "Mason", "Ezra", "John", "Hudson", "Luca", "Aiden", "Joseph",
    "David", "Jacob", "Logan", "Luke", "Julian", "Gabriel", "Grayson", "Wyatt", "Matthew", "Maverick",
    "Dylan", "Isaac", "Elias", "Anthony", "Thomas", "Jayden", "Carter", "Santiago", "Ezekiel", "Charles",
    "Josiah", "Caleb", "Cooper", "Lincoln", "Miles", "Christopher", "Nathan", "Isaiah", "Kai", "Joshua",
    "Andrew", "Angel", "Adrian", "Cameron", "Nolan", "Waylon", "Jaxon", "Roman", "Eli", "Wesley",
    "Aaron", "Ian", "Christian", "Ryan", "Leonardo", "Brooks", "Axel", "Walker", "Jonathan", "Easton",
    "Everett", "Weston", "Bennett", "Robert", "Jameson", "Landon", "Silas", "Jose", "Beau", "Micah",
    "Colton", "Jordan", "Jeremiah", "Parker", "Greyson", "Rowan", "Adam", "Nicholas", "Theo", "Xavier"
]
surnames = [
    "Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor",
    "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson",
    "Clark", "Rodriguez", "Lewis", "Lee", "Walker", "Hall", "Allen", "Young", "Hernandez", "King",
    "Wright", "Lopez", "Hill", "Scott", "Green", "Adams", "Baker", "Gonzalez", "Nelson", "Carter",
    "Mitchell", "Perez", "Roberts", "Turner", "Phillips", "Campbell", "Parker", "Evans", "Edwards", "Collins",
    "Stewart", "Sanchez", "Morris", "Rogers", "Reed", "Cook", "Morgan", "Bell", "Murphy", "Bailey",
    "Rivera", "Cooper", "Richardson", "Cox", "Howard", "Ward", "Torres", "Peterson", "Gray", "Ramirez",
    "James", "Watson", "Brooks", "Kelly", "Sanders", "Price", "Bennett", "Wood", "Barnes", "Ross",
    "Henderson", "Coleman", "Jenkins", "Perry", "Powell", "Long", "Patterson", "Hughes", "Flores", "Washington",
    "Butler", "Simmons", "Foster", "Gonzales", "Bryant", "Alexander", "Russell", "Griffin", "Diaz", "Hayes"
]
positions = [
    "Junior Doctor", "Senior Doctor", "Consultant", "Junior Resident", "Senior Resident", "Medical Director"
]

def generate_doctor_info():
    first_name = random.choice(names)
    last_name = random.choice(surnames)
    specialization = random.choice(specializations)
    position = random.choice(positions)
    pay = round(random.uniform(50000, 150000), 2)
    return {
        "first_name": first_name,
        "last_name": last_name,
        "specialization": specialization,
        "position": position,
        "pay": pay
    }

@app.route('/hire', methods=['GET', 'POST'])
def hire():
    if request.method == 'POST':
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        specialization = request.form['specialization']
        position = request.form['position']
        pay = request.form['pay']

        new_doctor = Doctor(
            first_name=first_name,
            last_name=last_name,
            specialization=specialization,
            position=position,
            pay=pay,
            patients_served=random.randint(90,100),
            success_rate=round(random.uniform(90,100),2)
        )
        db.session.add(new_doctor)
        db.session.commit()
        flash('Doctor hired successfully', 'success')
        return redirect(url_for('hire'))

    doctors_info = [generate_doctor_info() for _ in range(10)]
    return render_template('hire.html', doctors_info=doctors_info)


@app.route('/schedule')
def schedule():
    doctors = Doctor.query.all()
    patients = Patient.query.all()
    doctor_schedules = DoctorSchedule.query.all()
    patient_schedules = PatientSchedule.query.all()
    return render_template('schedule.html', doctors=doctors, patients=patients, doctor_schedules=doctor_schedules, patient_schedules=patient_schedules)

@app.route('/add_doctor_schedule', methods=['POST'])
def add_doctor_schedule():
    doctor_id = request.form['doctor_id']
    work_day = request.form['work_day']
    start_time = request.form['start_time']
    end_time = request.form['end_time']
    new_schedule = DoctorSchedule(doctor_id=doctor_id, work_day=work_day, start_time=start_time, end_time=end_time)
    db.session.add(new_schedule)
    db.session.commit()
    return redirect(url_for('schedule'))

@app.route('/add_patient_schedule', methods=['POST'])
def add_patient_schedule():
    patient_id = request.form['patient_id']
    appointment_day = request.form['appointment_day']
    appointment_time = request.form['appointment_time']
    doctor_id = request.form['doctor_id']
    new_schedule = PatientSchedule(patient_id=patient_id, appointment_day=appointment_day, appointment_time=appointment_time, doctor_id=doctor_id)
    db.session.add(new_schedule)
    db.session.commit()
    return redirect(url_for('schedule'))



@app.route('/resources', methods=['GET', 'POST'])
def resources():
    if request.method == 'POST':
        name = request.form['resource_name']
        quantity = request.form['quantity']
        threshold = request.form['threshold']
        price = request.form['price']
        allresources = Resource.query.filter_by(name=name).first()
        if allresources:
            allresources.quantity += (int)(quantity)
        else:
            new_resource = Resource(name=name, quantity=quantity, threshold=threshold, price=price)
            db.session.add(new_resource)
        db.session.commit()
        return redirect(url_for('resources'))
    resources = Resource.query.all()
    return render_template('resources.html', resources=resources)



@app.route('/finances')
def finances():
    finances = Finance.query.all()
    return render_template('finances.html', finances=finances)

@app.route('/set_budget', methods=['GET', 'POST'])
def set_budget():
    if request.method == 'POST':
        month = request.form['month']
        budget = Decimal(request.form['budget'])
        expenses = calculate_monthly_expenses()
        new_finance = Finance(month=month, budget=budget, expenses=expenses)
        db.session.add(new_finance)
        db.session.commit()
        flash('Budget set successfully', 'success')
        return redirect(url_for('finances'))
    return render_template('set_budget.html')

def calculate_monthly_expenses():
    doctor_salaries = db.session.query(func.sum(Doctor.pay)).scalar() or Decimal('0.0')
    staff_salaries = db.session.query(func.sum(Staff.pay)).scalar() or Decimal('0.0')
    resources_expenses = db.session.query(func.sum(Resource.price)).scalar() or Decimal('0.0')
    total_expenses = (int)(doctor_salaries) + (int)(staff_salaries) + (int)(resources_expenses)
    return total_expenses

@app.route('/finances_chart')
def finances_chart():
    finances = Finance.query.all()
    months = [f.month for f in finances]
    budgets = [float(f.budget) for f in finances]
    expenses = [float(f.expenses) for f in finances]

    plt.figure(figsize=(17, 8))
    plt.plot(months, budgets, label='Budget')
    plt.plot(months, expenses, label='Expenses')
    plt.xlabel('Month')
    plt.ylabel('Amount')
    plt.title('Budget vs Expenses')
    plt.legend()

    img = io.BytesIO()
    plt.savefig(img, format='png')
    img.seek(0)
    plot_url = base64.b64encode(img.getvalue()).decode('utf8')

    return render_template('finances_chart.html', plot_url=plot_url)


if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
