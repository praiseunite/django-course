# Session 2: Creating a Website

**Goal:** By the end of this session you will have created a Django app, wired up the full MVT pattern, and seen a real webpage served from your own database.

In our last session, we learned what Django is and how to start a server. But a project is just an empty container. Real functionality in Django comes from **Apps**. Today, we will learn how to create apps, activate them, and wire up the MVT (Model-View-Template) components to display our first real web page.

---

## How to Read a Django Error Screen

Before we write any code, here is the most important skill in Django development: **reading errors without panicking**.

When something goes wrong, Django shows a red error page in your browser. Here is how to read it:

1. **Look at the top** — it shows the error type (e.g., `OperationalError`, `TemplateDoesNotExist`)
2. **Look at the bottom of the traceback** — it shows the exact file and line number where the crash happened
3. **Read the last line** — that is the actual error message in plain English

The most common beginner errors and what they mean:

| Error | What it means |
| :--- | :--- |
| `OperationalError: no such table` | You forgot to run migrations after creating a model |
| `TemplateDoesNotExist` | Django cannot find your HTML file — check the folder path |
| `ModuleNotFoundError: No module named 'django'` | Your virtual environment is not activated |
| `NoReverseMatch` | The URL name in your code doesn't match any `name=` in `urls.py` |

---

## 1. Starting a Project (Recap)
A project is the entire web application. Think of the project as your school building.
```bash
django-admin startproject myschool
```
*Why? This sets up the central configuration, database connections, and overarching settings for everything that will be built inside.*

---

## 2. Creating an App Inside a Project
![Project vs App Concept](../../assets/project_vs_app_1782301001732.png)

While a project is the whole school, an **App** is a specific department (like the Library, the Cafeteria, or the Science department). A Django project can contain many apps, and apps can be reused in different projects.

To create an app, you must be inside your project folder (where `manage.py` lives).
```bash
cd myschool
python manage.py startapp students
```
*Why? `manage.py startapp` generates a new folder named `students` with pre-configured files (like `models.py` and `views.py`) dedicated specifically to handling student-related data and logic.*

---

## 3. Activating the App
Just creating the app folder doesn't mean Django knows about it. You have to explicitly tell the central project settings that the new app exists.

Open `myschool/settings.py` and find the `INSTALLED_APPS` list. Add your new app to the list:
```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    # Add your new app here:
    'students', 
]
```
*Why? Django only looks for database models, templates, and administrative configurations in apps that are formally registered in this list. If you forget this step, Django will ignore your new app.*

---

## 4. Wiring the MVT: Templates, Views, URLs, and Models

Now we will follow the MVT architecture to display a simple list of students. We will do this step-by-step.

### Step 4A: Create the Model (The Database)
Open `students/models.py`. Here we define what a "Student" is.
```python
from django.db import models

class Student(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)

    def __str__(self):
        return self.first_name + " " + self.last_name
```
*Why? We are telling Django to create a database table with two text columns (first_name, last_name). `models.CharField` tells the database to expect text. The `__str__` method ensures the student is displayed by their name rather than as "Object 1" in the system.*

---

### Step 4A.5: Run Migrations (REQUIRED — Do Not Skip)

> ⚠️ **You must do this before the next step or the server will crash with `OperationalError: no such table`.**

Every time you create or modify a model, you must tell Django to update the database. This is a two-command process:

```bash
# Step 1: Create a blueprint of your changes
python manage.py makemigrations

# Step 2: Apply the blueprint to the actual database
python manage.py migrate
```

You will see output like:
```
Migrations for 'students':
  students/migrations/0001_initial.py
    - Create model Student

Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions, students
Running migrations:
  Applying students.0001_initial... OK
```

*Why? Django keeps your Python code and the actual database in sync using "migrations". `makemigrations` writes a migration file. `migrate` reads it and builds the real database table. Skip either step and your view will crash.*

---

### Step 4A.6: Add Some Test Data (Using the Django Shell)

The database table exists now but it is empty. An empty database means an empty webpage. Let's add two students so we have something to display:

```bash
python manage.py shell
```

Inside the shell, type these commands one at a time:

```python
from students.models import Student
Student.objects.create(first_name="Alice", last_name="Smith")
Student.objects.create(first_name="Bob", last_name="Jones")
exit()
```

*Why? The Django shell is a Python terminal with your entire project loaded. `Student.objects.create()` inserts a row directly into the database. In Session 4 we will use the Admin Panel to do this from a web browser — no more typing in the terminal.*

---

### Step 4B: Create the View (The Logic)

Django views have two levels of complexity. Let's learn the simplest one first, then the full version.

**The Simplest View — `HttpResponse`:**
```python
from django.http import HttpResponse

def simple_view(request):
    return HttpResponse("<h1>Hello, World!</h1>")
```
*Why? `HttpResponse` sends text or raw HTML directly back to the browser. It requires no HTML file. This is useful for testing that your URL wiring works before you create templates.*

**The Full View — `render()` with a template:**

Open `students/views.py` and write the real view:
```python
from django.shortcuts import render
from .models import Student

def student_list(request):
    # Fetch all students from the database
    all_students = Student.objects.all() 
    
    # Pass the data to the template
    return render(request, 'students/student_list.html', {'students': all_students})
```
*Why? The `request` object contains data from the user's browser. `Student.objects.all()` asks the database for every student. `render` combines our HTML file with the database data and sends it back to the user.*

---

### Step 4C: Create the Template (The HTML)

Inside the `students` folder, create the following folder and file structure exactly:

```
students/
├── templates/
│   └── students/        ← repeat the app name as a second folder
│       └── student_list.html
├── views.py
├── models.py
└── urls.py
```

> The most common mistake here is creating `students/templates/student_list.html` and forgetting the inner `students/` folder. Django will not find the file without the inner folder.

Create `students/templates/students/student_list.html` with this content:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Student List</title>
</head>
<body>
    <h1>Our Students</h1>
    <ul>
        {% for student in students %}
            <li>{{ student.first_name }} {{ student.last_name }}</li>
        {% endfor %}
    </ul>
</body>
</html>
```
*Why? The `{% %}` and `{{ }}` tags are Django's template language. They allow us to write a loop in HTML. `{{ student.first_name }}` injects the database data directly into the webpage.*

---

### Step 4D: Connect the URLs (The Routing)
How does a user actually trigger the view? We need to connect a URL to the View.

First, create a new file `urls.py` inside the `students` app folder:
```python
from django.urls import path
from . import views

urlpatterns = [
    path('list/', views.student_list, name='student_list'),
]
```
*Why? This says: "If a user goes to the `/list/` URL, run the `student_list` view function."*

Next, we must tell the MAIN project about the app's URLs. Open `myschool/urls.py` and modify it:
```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    # Add this line:
    path('students/', include('students.urls')), 
]
```
*Why? The main `urls.py` delegates traffic. If the URL starts with `students/`, it hands control over to the `students` app's `urls.py`. The final URL will be `127.0.0.1:8000/students/list/`.*

---

## 5. Run the Server and Test

```bash
python manage.py runserver
```

Open your browser and visit: `http://127.0.0.1:8000/students/list/`

You should see **"Our Students"** with Alice Smith and Bob Jones listed. If you see a blank list (no names), go back to Step 4A.6 and add the test data.

---

## Recommended Video Tutorials
Students can search for the following excellent YouTube tutorials on their own to supplement this session:

1. Corey Schafer - Django Tutorial Part 2: Applications & Routes
2. Traversy Media - Django Crash Course
3. FreeCodeCamp - Django Web Development Course
4. Dennis Ivy - Django App Routing
