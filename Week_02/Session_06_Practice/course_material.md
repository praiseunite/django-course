# Session 6: Full Cumulative Practical Lab — "AptechHub Student Portal"

**Objective:** Today we build ONE complete, working web application from start to finish using EVERY concept covered in Sessions 1 through 5 — no shortcuts, no skipping steps.

By the end of this session you will have a running web application with:
- A working Django project and registered app
- A database model with real data managed through the Admin Panel
- A **Function-Based View** and a **Class-Based View** displaying the same data
- Proper URL routing wired through both the app and the project
- HTML templates using Django's template language
- A superuser account with a customised Admin interface

> This is not a theory session. Every line of code in this document should be typed by the students in real time.

---

# PHASE 1 — FROM SESSION 1: Project Setup, Environment & Folder Structure

*Session 1 taught us: Virtual environments, `startproject`, `startapp`, and the meaning of every file in the project folder.*

## Step 1.1 — Create and Activate the Virtual Environment

Open your terminal. Navigate to where you keep your projects.

```bash
# Create a clean isolated box for this project
python -m venv aptechhub_env
```

Now activate it:
- **Windows:** `aptechhub_env\Scripts\activate`
- **Mac/Linux:** `source aptechhub_env/bin/activate`

> ✅ You will see `(aptechhub_env)` at the start of your terminal line. This confirms you are inside the box.

## Step 1.2 — Install Django

```bash
pip install django
```

## Step 1.3 — Create the Django Project

```bash
django-admin startproject aptechhub
cd aptechhub
```

## Step 1.4 — Understand the Files Django Just Created

Before writing a single line of code, let's look at what was created and what each file does:

```text
aptechhub/                   <-- The outer root container. Just a folder.
    manage.py                <-- Your control panel. You run ALL commands through this file.
    aptechhub/               <-- The actual Python package for your project config.
        __init__.py          <-- Empty file. Tells Python: "this folder is a package."
        settings.py          <-- The BRAIN. Database config, installed apps, timezone, etc.
        urls.py              <-- The TABLE OF CONTENTS. Routes URLs to the right code.
        asgi.py              <-- Entry-point for async web servers (advanced/deployment).
        wsgi.py              <-- Entry-point for traditional web servers (deployment).
```

**What you will touch today:**
- `settings.py` — to register your app
- `urls.py` — to connect project-level routes to your app

**What you will NOT touch today:**
- `__init__.py`, `asgi.py`, `wsgi.py` — these are for Python internals and deployment. Leave them as-is.

## Step 1.5 — Test That the Project Works

```bash
python manage.py runserver
```

Open your browser and go to `http://127.0.0.1:8000`. You should see the Django rocket launch page. This confirms the project is alive.

Press `Ctrl+C` to stop the server before moving on.

---

# PHASE 2 — FROM SESSION 2: Creating an App, MVT Wiring & URL Routing

*Session 2 taught us: Creating apps, registering them in settings.py, writing the Model, View, Template, and wiring the URL chain from app to project.*

## Step 2.1 — Create the App

```bash
python manage.py startapp students
```

This creates a new `students/` folder. Look inside it:

```text
students/
    admin.py         <-- Where you register models to appear in the Admin dashboard
    apps.py          <-- App configuration file (rarely edited)
    models.py        <-- Where you define your database tables
    tests.py         <-- Where you write automated tests (not covered today)
    views.py         <-- Where you write your Python view logic (FBV and CBV)
    migrations/      <-- Django automatically stores database change history here
        __init__.py
```

## Step 2.2 — Register the App in `settings.py`

Open `aptechhub/settings.py`. Find the `INSTALLED_APPS` list and add your new app:

```python
# aptechhub/settings.py

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    # WHY: Without this line, Django completely ignores our students app.
    # It won't load our models, templates, or admin configuration.
    'students',
]
```

## Step 2.3 — Create the Model (The Database Table)

Open `students/models.py` and define what a Student looks like:

```python
# students/models.py
from django.db import models

class Student(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    course = models.CharField(max_length=100)
    year = models.IntegerField(default=1)
    bio = models.TextField(blank=True)  # blank=True means this field is optional

    def __str__(self):
        # WHY: Without this, the Admin panel shows "Student object (1)" — unhelpful.
        # With this, it shows the student's full name everywhere.
        return f"{self.first_name} {self.last_name}"
```

**Field types used (recap):**
| Field | What it stores |
|---|---|
| `CharField(max_length=n)` | Short text (names, titles) |
| `IntegerField(default=1)` | Whole numbers |
| `TextField` | Long text (paragraphs) |

## Step 2.4 — Run Migrations (NEVER Skip This)

Every time you create or change a model, you MUST run these two commands:

```bash
# Step 1: Generate a migration file — a blueprint of your changes
python manage.py makemigrations

# Step 2: Apply the blueprint to the actual SQLite database
python manage.py migrate
```

You should see:
```
Migrations for 'students':
  students/migrations/0001_initial.py
    - Create model Student
Running migrations:
  Applying students.0001_initial... OK
```

> ⚠️ If you skip this step and try to run the server, you will get: `OperationalError: no such table: students_student`. The table does not exist in the database until you migrate.

## Step 2.5 — Create the Template Folder and HTML File

Inside the `students` folder, create this exact folder structure:

```text
students/
├── templates/
│   └── students/          <-- IMPORTANT: repeat the app name as a subfolder
│       └── student_list.html
```

> **The most common mistake:** Students create `students/templates/student_list.html` and skip the inner `students/` folder. Django will NOT find it. The path must be `templates/students/student_list.html`.

Create `students/templates/students/student_list.html` with this content:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AptechHub — Student List</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 40px auto; }
        h1 { color: #2c3e50; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background-color: #2c3e50; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>AptechHub Student Portal</h1>
    <p>Total Students: <strong>{{ students|length }}</strong></p>

    <!-- WHY: {% %} are template TAGS — they run logic like loops -->
    <!-- WHY: {{ }} are template VARIABLES — they print a value -->
    {% if students %}
        <table>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Course</th>
                <th>Year</th>
            </tr>
            {% for student in students %}
                <tr>
                    <td>{{ student.first_name }}</td>
                    <td>{{ student.last_name }}</td>
                    <td>{{ student.course }}</td>
                    <td>Year {{ student.year }}</td>
                </tr>
            {% endfor %}
        </table>
    {% else %}
        <p>No students found. Add some through the Admin panel!</p>
    {% endif %}
</body>
</html>
```

## Step 2.6 — Create the App-Level `urls.py`

Django does not create a `urls.py` inside your app automatically. Create a new file at `students/urls.py`:

```python
# students/urls.py
from django.urls import path
from . import views  # WHY: import all views from this same app (the dot means "current app")

urlpatterns = [
    # We will add our view paths here in Phase 3 and Phase 4
]
```

## Step 2.7 — Connect App URLs to the Project

Open `aptechhub/urls.py` and include the app's URL file:

```python
# aptechhub/urls.py
from django.contrib import admin
from django.urls import path, include  # WHY: include() lets us delegate URL patterns to apps

urlpatterns = [
    path('admin/', admin.site.urls),

    # WHY: Any URL that starts with 'students/' will be handed off to students/urls.py
    # This keeps the project urls.py clean and each app self-contained
    path('students/', include('students.urls')),
]
```

---

# PHASE 3 — FROM SESSION 4: Admin Panel, Superuser & Customization

*Session 4 taught us: Creating a superuser, registering models in admin.py, customizing the list view with list_display, search_fields, and list_filter.*

## Step 3.1 — Create a Superuser

```bash
python manage.py createsuperuser
```

Enter your chosen username, email, and password when prompted. The password will not show on screen — that is normal.

## Step 3.2 — Register the Model in the Admin Panel

Open `students/admin.py`:

```python
# students/admin.py
from django.contrib import admin
from .models import Student

# WHY: ModelAdmin lets us control how the model LOOKS in the Admin dashboard
class StudentAdmin(admin.ModelAdmin):
    # WHY: list_display turns the boring "Student object(1)" list into a proper data table
    list_display = ('first_name', 'last_name', 'course', 'year')

    # WHY: search_fields adds a search bar at the top — you can search by name
    search_fields = ('first_name', 'last_name', 'course')

    # WHY: list_filter adds a clickable filter sidebar on the right to filter by year
    list_filter = ('year', 'course')

# WHY: This line is what connects the model AND the customization to the Admin site
admin.site.register(Student, StudentAdmin)
```

## Step 3.3 — Add Real Data Through the Admin Panel

Run the server and go to `http://127.0.0.1:8000/admin/`. Log in with your superuser credentials.

1. Click **Students** in the sidebar
2. Click **+ Add Student** in the top right
3. Add at least **4 students** with different courses and years

> **Sample data to add:**
> - Ada Lovelace | Python Programming | Year 2
> - Alan Turing | Cybersecurity | Year 1
> - Grace Hopper | Web Development | Year 3
> - Tim Berners | Database Management | Year 1

Notice how the `list_display`, `search_fields`, and `list_filter` you configured are now visible and working in the Admin panel.

---

# PHASE 4 — FROM SESSION 5: Function-Based Views (FBV)

*Session 5 taught us: What views are, the request object, writing FBVs, redirecting, and wiring URLs.*

## Step 4.1 — Write the Function-Based View

Open `students/views.py`:

```python
# students/views.py
from django.shortcuts import render
from .models import Student

# ============================================================
# FUNCTION-BASED VIEW (FBV)
# ============================================================
# WHY FBV: The logic is written explicitly, line by line.
# You can SEE exactly what is happening — great for learning
# and for custom logic that doesn't fit a standard pattern.
# ============================================================

def student_list_fbv(request):
    # Step 1: The request object arrives from the browser
    # request.method will be 'GET' here (the user is just viewing the page)
    print(f"Request method: {request.method}")  # you can see this in the terminal

    # Step 2: Ask the Model for data from the database
    # .all() fetches every row in the Student table
    all_students = Student.objects.all()

    # Step 3: Package the data into a context dictionary
    # The KEY ('students') is what the template will use to access the data
    context = {
        'students': all_students,
        'view_type': 'Function-Based View',  # we'll display this in the template
    }

    # Step 4: Render — combine the template HTML file with the context data
    # and send the final HTML page back to the user's browser
    return render(request, 'students/student_list.html', context)
```

## Step 4.2 — Wire the FBV to a URL

Open `students/urls.py` and add the path:

```python
# students/urls.py
from django.urls import path
from . import views

urlpatterns = [
    # WHY: We pass the view FUNCTION directly — no parentheses, no .as_view()
    # because it is already a callable function
    path('fbv/', views.student_list_fbv, name='student_list_fbv'),
]
```

## Step 4.3 — Test the FBV

Run the server: `python manage.py runserver`

Visit: `http://127.0.0.1:8000/students/fbv/`

You should see the full student table rendered from your database. The URL chain that fired to get here was:

```
Browser visits /students/fbv/
    → Project urls.py sees "students/" → hands off to students/urls.py
    → students/urls.py sees "fbv/" → calls student_list_fbv(request)
    → FBV fetches all students from the database
    → FBV renders student_list.html with the data
    → Browser receives and displays the final HTML page
```

---

# PHASE 5 — FROM SESSION 5: Class-Based Views (CBV)

*Session 5 also taught us: CBVs using ListView and TemplateView, and how to wire them differently in urls.py with .as_view().*

## Step 5.1 — Add the CBV to `views.py`

Open `students/views.py` and ADD the following below the existing FBV (do not delete the FBV):

```python
# students/views.py  (add BELOW the existing FBV code)
from django.views.generic import ListView, TemplateView

# ============================================================
# CLASS-BASED VIEW (CBV) — ListView
# ============================================================
# WHY CBV: Django's generic ListView does the exact same job
# as the FBV above, but in 4 lines instead of 10.
# It automatically fetches all objects and passes them to the template.
# The trade-off: the logic is hidden inside Django's parent class.
# ============================================================

class StudentListCBV(ListView):
    model = Student  # WHY: tells ListView WHICH model to fetch from the database

    # WHY: By default, ListView looks for a template named 'students/student_list.html'
    # (app_name/modelname_list.html). Since our file matches, this line is optional here,
    # but we keep it explicit so there is no confusion.
    template_name = 'students/student_list.html'

    # WHY: ListView passes data to the template under the key 'object_list' by default.
    # We rename it to 'students' so our existing template works without changes.
    context_object_name = 'students'

    # BONUS: We can override the context to add extra data, just like we did in the FBV
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['view_type'] = 'Class-Based View (ListView)'
        return context


# ============================================================
# CLASS-BASED VIEW — TemplateView (for pages with NO database data)
# ============================================================
# WHY TemplateView: Sometimes you just want to render a plain HTML page
# (like a Home page or an About page) without fetching anything from the database.
# ============================================================

class HomePageView(TemplateView):
    template_name = 'students/home.html'
```

## Step 5.2 — Create the Home Page Template

Create a new file: `students/templates/students/home.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AptechHub — Home</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 80px; }
        h1 { color: #2c3e50; font-size: 3em; }
        p { font-size: 1.2em; color: #555; }
        a { display: inline-block; margin: 10px; padding: 12px 24px;
            background: #2c3e50; color: white; text-decoration: none; border-radius: 5px; }
        a:hover { background: #3498db; }
    </style>
</head>
<body>
    <h1>Welcome to AptechHub</h1>
    <p>Your student management portal</p>
    <br>
    <!-- Django template tag — url tag generates a URL from a named route -->
    <a href="{% url 'student_list_fbv' %}">View Students (FBV)</a>
    <a href="{% url 'student_list_cbv' %}">View Students (CBV)</a>
</body>
</html>
```

## Step 5.3 — Update the Template to Show Which View is Active

Open `students/templates/students/student_list.html` and add a banner line just below the `<h1>` tag:

```html
<!-- Add this line below the <h1> tag -->
<p style="background:#3498db; color:white; padding:8px; border-radius:4px;">
    Rendered by: <strong>{{ view_type }}</strong>
</p>
```

This lets students see VISUALLY which view (FBV or CBV) served the page — proving both routes work identically.

## Step 5.4 — Wire Both CBVs to URLs

Open `students/urls.py` and add the two new paths:

```python
# students/urls.py
from django.urls import path
from . import views

urlpatterns = [
    # FBV — pass the function directly
    path('fbv/', views.student_list_fbv, name='student_list_fbv'),

    # CBV ListView — MUST call .as_view() because it is a class, not a function
    # WHY: .as_view() converts the class into a callable function that Django's URL
    # router can actually use. Forgetting it causes a TypeError.
    path('cbv/', views.StudentListCBV.as_view(), name='student_list_cbv'),

    # CBV TemplateView — also needs .as_view()
    path('', views.HomePageView.as_view(), name='home'),
]
```

---

# PHASE 6 — FULL TEST & COMPARISON

## Step 6.1 — Run the Server

```bash
python manage.py runserver
```

## Step 6.2 — Visit Every URL

| URL | What you should see | Which view serves it |
|---|---|---|
| `http://127.0.0.1:8000/students/` | AptechHub Welcome Home page with two buttons | `HomePageView` (TemplateView CBV) |
| `http://127.0.0.1:8000/students/fbv/` | Student table — banner says "Function-Based View" | `student_list_fbv` (FBV) |
| `http://127.0.0.1:8000/students/cbv/` | Student table — banner says "Class-Based View (ListView)" | `StudentListCBV` (CBV) |
| `http://127.0.0.1:8000/admin/` | Admin dashboard with Students, Users, Groups | Django built-in admin |

## Step 6.3 — Final Architecture Review

Looking at the completed project, connect every file back to its session:

```text
aptechhub/                      ← Session 1: startproject
├── manage.py                   ← Session 1: command-line control panel
├── aptechhub/
│   ├── settings.py             ← Session 2: INSTALLED_APPS registration
│   └── urls.py                 ← Session 2: include() to delegate to app urls
└── students/
    ├── models.py               ← Session 2: Student database model
    ├── admin.py                ← Session 4: Superuser + list_display + search_fields
    ├── views.py                ← Session 5: FBV + CBV ListView + CBV TemplateView
    ├── urls.py                 ← Session 5: FBV path + .as_view() for CBVs
    └── templates/
        └── students/
            ├── home.html       ← Session 2: HTML template (TemplateView target)
            └── student_list.html ← Session 2: HTML template (FBV + ListView target)
```

---

# PHASE 7 — ERROR RECOGNITION DRILL (Last 15 Minutes)

As a class, the instructor will intentionally break the project in these ways, and students must diagnose the error:

| The instructor will... | Error the student will see | The fix |
|---|---|---|
| Delete `'students'` from `INSTALLED_APPS` | App stops working entirely | Re-add `'students'` to `settings.py` |
| Remove `.as_view()` from the CBV URL | `TypeError: view must be a callable` | Add `.as_view()` back |
| Delete the inner `students/` templates folder | `TemplateDoesNotExist` | Restore the correct folder path |
| Comment out `migrate` and add a new field | `OperationalError: no such column` | Run `makemigrations` then `migrate` |
| Remove `include('students.urls')` from project urls | `404 Page Not Found` | Re-add the `include()` line |

---

## Recommended Video Tutorials
Students can search for the following excellent YouTube tutorials on their own to supplement this session:

1. Tech With Tim - Django Framework Tutorial
2. Corey Schafer - Django Tutorial Part 11: Pagination
3. Programming with Mosh - Django App Practice
4. Corey Schafer - Django Applications
