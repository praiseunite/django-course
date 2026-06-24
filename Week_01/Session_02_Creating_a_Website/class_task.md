# Class Task: Building the Students App

**Objective:** Create an app, activate it, build a model, create some dummy data, and display it using the MVT pattern.

### Step 1: Open Your Project
Open the terminal, activate your virtual environment, and navigate into the `school_project` folder you created in Session 1.
```bash
# Windows
djenv\Scripts\activate
cd school_project

# Mac/Linux
source djenv/bin/activate
cd school_project
```

### Step 2: Create the App
Create a new app called `directory`.
```bash
python manage.py startapp directory
```
*Why? This creates a new folder holding the specific files needed for our directory logic.*

### Step 3: Activate the App
Open `school_project/settings.py` and add `'directory',` to the `INSTALLED_APPS` list.
*Why? Without this, Django's core engine will ignore the new app folder entirely.*

### Step 4: Create a Simple View
Open `directory/views.py` and write a basic view that doesn't even need a database yet.
```python
from django.http import HttpResponse

def welcome(request):
    return HttpResponse("<h1>Welcome to the School Directory!</h1>")
```
*Why? `HttpResponse` is the simplest way to send data back. Instead of an HTML file, we are sending raw HTML code straight from the view.*

### Step 5: Wire the App URLs
Create a new file `directory/urls.py`:
```python
from django.urls import path
from . import views

urlpatterns = [
    path('welcome/', views.welcome, name='welcome'),
]
```

### Step 6: Wire the Project URLs
Open `school_project/urls.py` and link the app:
```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('dir/', include('directory.urls')),
]
```
*Why? `include()` connects the main project traffic controller to the app's traffic controller.*

### Step 7: Test Your Work
Run the server:
```bash
python manage.py runserver
```
Open your browser and visit: `http://127.0.0.1:8000/dir/welcome/`. You should see your welcome message!
