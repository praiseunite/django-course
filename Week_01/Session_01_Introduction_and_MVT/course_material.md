# Session 1 & 2: Introduction to Django & MVT Architecture

Welcome to the exciting world of web development! In this session, we will introduce you to Django, a powerful framework for building web applications using Python. We will cover what it is, how to set up your environment, and the architecture that powers it.

---

## Part 1: Introduction to Django

### 1. What is Django?
Django is a high-level Python web framework that encourages rapid development and clean, pragmatic design. Built by experienced developers, it takes care of much of the hassle of web development, so you can focus on writing your app without needing to reinvent the wheel. It’s free and open source.

Think of a framework like a pre-built house structure. Instead of making bricks and mixing cement yourself, the framework gives you the walls, roof, and foundation. You just need to paint the walls, choose the furniture, and arrange the rooms (i.e., build your specific application logic).

### 2. Features of Django
*   **"Batteries Included":** Django comes with many common web development tools out of the box, such as user authentication, a built-in admin panel, and database management tools.
*   **Fast:** It was designed to help developers take applications from concept to completion as quickly as possible.
*   **Secure:** Django helps developers avoid many common security mistakes, such as SQL injection, cross-site scripting (XSS), and clickjacking.
*   **Scalable:** Some of the busiest sites on the internet (like Instagram and Pinterest) use Django to quickly and flexibly scale to handle heavy traffic demands.

### 3. Application of Django Framework
Because of its versatility, Django is used to build almost any type of website:
*   Content Management Systems (CMS)
*   Social Networks
*   Scientific Computing Platforms
*   E-commerce Sites

### 4. Setting up the Django Environment
Before we write any code, we need to prepare our workspace. We will be using the command line (Terminal on Mac/Linux or Command Prompt/PowerShell on Windows).

**Step 1: The Virtual Environment**
*Why do we need this?* Imagine you are working on two projects: Project A needs Django version 3, and Project B needs Django version 5. If you install Django globally on your computer, they will conflict. A virtual environment is an isolated "box" for your project. What happens in the box stays in the box.

```bash
# This command tells python to use its built-in 'venv' module to create a new folder called 'myenv' which will hold our isolated environment.
python -m venv myenv
```

**Step 2: Activating the Environment**
*Why do we need this?* Creating the box isn't enough; we have to step inside it.
*   On Windows: `myenv\Scripts\activate`
*   On Mac/Linux: `source myenv/bin/activate`

**Step 3: Installing Django**
*Why do we need this?* Now that we are inside our isolated box, we use `pip` (Python's package installer) to download Django from the internet and install it inside this specific box.
```bash
pip install django
```

**Step 4: Creating a Django Project and App**
*Why do we need this?* We need a starting point! Django provides a command that automatically generates a basic folder structure.
```bash
# Generate the main project container
django-admin startproject mysite
cd mysite

# Generate a specific feature app inside the project
python manage.py startapp demo_app
```

### 5. Understanding the Folder Structure & Configuration
When you run the commands above, Django creates a specific folder structure. Let's explore what each file does and how we edit them.

```text
mysite/                  <-- The outer root directory. Just a container for your project.
    manage.py            <-- A command-line utility that lets you interact with this project (e.g., running the server).
    
    mysite/              <-- The actual Python package for your project settings.
        settings.py      <-- Configuration settings. The central brain of the project.
        urls.py          <-- The Table of Contents. Routes a web URL to the correct code.
        
    demo_app/            <-- The feature app we just created.
        models.py        <-- Where you define your database tables.
        views.py         <-- Where you write your Python logic and functions.
```

#### How we edit these files:
Whenever you create a new app like `demo_app`, you MUST tell the central brain (`settings.py`) that it exists. 

**Editing `mysite/settings.py`:**
```python
# Inside mysite/settings.py, find the INSTALLED_APPS list and add your new app.
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    
    # MY CUSTOM APPS
    'demo_app',  # <-- You add this line!
]
```

Next, you need to tell Django's Table of Contents (`urls.py`) how to find your app's web pages.

**Editing `mysite/urls.py`:**
```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('demo/', include('demo_app.urls')), # <-- You add this line to route traffic!
]
```

---

## Part 2: Model View Template (MVT) Architecture

### 1. What is MVT?
Any modern web application needs a way to organize its code so it doesn't become a tangled mess. Django uses a pattern called **MVT (Model-View-Template)**.
*   **Model:** The Data Layer. It defines your database structure.
*   **View:** The Logic Layer. The brain that connects the user, the database, and the template. 
*   **Template:** The Presentation Layer. This is what the user actually sees on their screen (HTML, CSS). 

### 2. Structure of MVT
![MVT Architecture Flow](../../assets/mvt_architecture_1782300990188.png)

Imagine a restaurant:
1.  **User Request:** A customer orders a burger from the menu.
2.  **View (The Waiter):** Takes the order and goes to the kitchen.
3.  **Model (The Chef & Pantry):** Gathers the ingredients (data) from the pantry (database).
4.  **Template (The Plate):** The presentation of the burger on a nice plate.
5.  **User Response:** The waiter delivers the plated burger back to the customer.

### 3. MVT in Action: Code Samples
Let's see what the Waiter, Chef, and Plate look like in actual Python code for a simple blog app.

**The Model (`models.py`) - The Database Chef:**
```python
from django.db import models

class Post(models.Model):
    title = models.CharField(max_length=200)
    content = models.TextField()
    
    def __str__(self):
        return self.title
```

**The View (`views.py`) - The Logic Waiter:**
```python
from django.shortcuts import render
from .models import Post

def home_view(request):
    # 1. Ask the Model for data
    all_posts = Post.objects.all() 
    
    # 2. Hand the data to the Template
    return render(request, 'home.html', {'posts': all_posts})
```

**The Template (`home.html`) - The HTML Plate:**
```html
<!DOCTYPE html>
<html>
<body>
    <h1>My Blog</h1>
    
    <!-- We dynamically display the data passed from the View -->
    {% for post in posts %}
        <h2>{{ post.title }}</h2>
        <p>{{ post.content }}</p>
    {% endfor %}
</body>
</html>
```

### 4. Difference between MVT and MVC
You might hear professional developers talk about **MVC (Model-View-Controller)**. Django's MVT is very similar, but the names are shifted:

*   **Model (MVC)** = **Model (MVT)**: Both handle data.
*   **View (MVC)** = **Template (MVT)**: What MVC calls a View (presentation), Django calls a Template.
*   **Controller (MVC)** = **View (MVT)**: What MVC calls a Controller (logic/brain), Django calls a View.

*Where is the Controller in Django?* In Django, the framework itself acts as the Controller! It handles the routing of requests to the correct View automatically.


## Recommended Video Tutorials
Students can search for the following excellent YouTube tutorials on their own to supplement this session:

1. Corey Schafer - Django Tutorial Part 1: Getting Started
2. Programming with Mosh - Django Tutorial for Beginners
3. Tech With Tim - Django Framework Tutorial - Part 1
4. Dennis Ivy - Django Crash Course
