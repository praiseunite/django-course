# Class Task: "Try It Yourself" Challenge

**Objective:** Combine Admin management and View creation. You will build a mini "Employee Directory" app.

### Task 1: Setup the App
1. Create a new Django project called `company_portal`.
2. Create an app called `hr` (Human Resources).
3. Register the `hr` app in `settings.py`.

### Task 2: The Model & The Admin
1. In `hr/models.py`, create an `Employee` model with three fields:
   * `first_name` (CharField)
   * `last_name` (CharField)
   * `department` (CharField)
2. Run your migrations!
3. Create a superuser.
4. In `hr/admin.py`, customize the Admin panel so that the `Employee` model displays all three fields in the list view (`list_display`).
5. Log into the Admin panel and add 4 fake employees.

### Task 3: The Function-Based View (FBV)
1. In `hr/views.py`, write a function called `employee_list_fbv`.
2. This view should fetch all employees from the database and pass them to a template called `hr/fbv_list.html`.
3. Create the template and use a `{% for %}` loop to display the employees.
4. Route this view in your `urls.py` to `http://127.0.0.1:8000/employees-fbv/`.

### Task 4: The Class-Based View (CBV)
1. In `hr/views.py`, import `ListView`.
2. Create a class called `EmployeeListCBV` that inherits from `ListView`.
3. Connect it to the `Employee` model and tell it to use a template called `hr/cbv_list.html`.
4. Create the template and display the employees.
5. Route this view in your `urls.py` to `http://127.0.0.1:8000/employees-cbv/`.

### Task 5: Verification
Run your server. Check both URLs. They should display the exact same list of employees, proving that you successfully wrote the logic in two different ways!
