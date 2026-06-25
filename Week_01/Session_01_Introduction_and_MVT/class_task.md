# Class Task: Your First Django Project

**Objective:** To practice creating a virtual environment, installing Django, configuring your settings, and writing a basic "Hello World" MVT application.

---

## Part 1: Instructor Guided Example (Hello World)
Follow along with your instructor to build a simple application that outputs "Hello World" to your browser.

### Step 1: Environment and Project Setup
1. Create your folder and virtual environment:
   ```bash
   mkdir aptech_django
   cd aptech_django
   python -m venv djenv
   ```
2. Activate the environment:
   - Windows: `djenv\Scripts\activate`
   - Mac/Linux: `source djenv/bin/activate`
3. Install Django and start the project/app:
   ```bash
   pip install django
   django-admin startproject hello_project
   cd hello_project
   python manage.py startapp hello_app
   ```

### Step 2: Configure the Brain (`settings.py`)
Open `hello_project/settings.py` and register your new app:
```python
INSTALLED_APPS = [
    # ... other apps ...
    'hello_app', # Add your app here
]
```

### Step 3: Write the Logic (The View)
Open `hello_app/views.py` and write your first view function:
```python
from django.http import HttpResponse

def say_hello(request):
    return HttpResponse("<h1>Hello World! Welcome to Django!</h1>")
```

### Step 4: Route the Traffic (The URLs)
Open `hello_project/urls.py` and point a URL path to your new view:
```python
from django.contrib import admin
from django.urls import path
from hello_app import views # Import your views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('hello/', views.say_hello), # Route traffic to your view
]
```

### Step 5: Run and Test
Run the server:
```bash
python manage.py runserver
```
Visit `http://127.0.0.1:8000/hello/` in your browser to see your message!

---

## Part 2: Independent Student Task (Your Turn!)
Now that you have seen how it works, it is your turn to build a project from scratch on your own.

**The Challenge:**
1. Create a brand new project called `school_project`.
2. Inside it, create an app called `directory_app`.
3. Register your app in `school_project/settings.py`.
4. In `directory_app/views.py`, write a view function called `welcome_students` that returns an `HttpResponse` saying `"Welcome to the Aptech Student Directory!"`.
5. In `school_project/urls.py`, wire up the URL so that visiting `http://127.0.0.1:8000/directory/` displays your welcome message.
6. Run the server and test it in your browser. Call the instructor over to verify your success!
