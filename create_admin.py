from app import app, db, bcrypt
from app import Admin

# Ensure the script runs within the application context
with app.app_context():
    # Prompt the user to enter a new username and password
    new_username = input("Enter the new admin username: ")
    new_password = input("Enter the new admin password: ")

    # Check if admin with the given username already exists
    existing_admin = Admin.query.filter_by(username=new_username).first()
    if existing_admin:
        print("Admin with that username already exists!")
    else:
        # Generate a new hashed password
        hashed_password = bcrypt.generate_password_hash(new_password).decode('utf-8')

        # Create a new admin user with the provided username and hashed password
        new_admin = Admin(username=new_username, password=hashed_password)

        db.session.add(new_admin)
        db.session.commit()

        print("New admin user created successfully!")
