# Session 3: Practice & "Try It Yourself" Lab

Welcome to the first dedicated lab session! This session is designed entirely around hands-on practice. The goal is to consolidate Sessions 1 and 2: environment setup, starting projects, creating apps, and basic MVT wiring.

---

## Student Quick Reference

Use this as a cheat sheet while you work through the tasks.

### Terminal Commands
```bash
# Activate virtual environment
djenv\Scripts\activate          # Windows
source djenv/bin/activate       # Mac/Linux

# Create a new Django project
django-admin startproject project_name

# Navigate into the project
cd project_name

# Create an app inside the project
python manage.py startapp app_name

# Create database tables (always after changing models.py)
python manage.py makemigrations
python manage.py migrate

# Start the development server
python manage.py runserver

# Open the Django shell (to add test data)
python manage.py shell
```

### MVT Wiring Checklist
Every time you build a new page, follow this checklist in order:

- [ ] **Model** — define the class in `app/models.py`
- [ ] **Migrations** — run `makemigrations` then `migrate`
- [ ] **View** — write the function in `app/views.py`
- [ ] **Template** — create `app/templates/app/file.html`
- [ ] **App URLs** — create `app/urls.py` with the path
- [ ] **Project URLs** — add `include('app.urls')` to `project/urls.py`
- [ ] **Test** — run the server and visit the URL in the browser

### Template Folder Structure
```
my_app/
├── templates/
│   └── my_app/          ← always repeat the app name here
│       └── index.html
```

### Common Errors and Fixes

| Error message | What to do |
| :--- | :--- |
| `Command 'django-admin' not found` | Activate your virtual environment |
| `ModuleNotFoundError: No module named 'django'` | Activate your virtual environment |
| `No such file or directory: manage.py` | `cd` into the folder that contains `manage.py` |
| `OperationalError: no such table` | Run `makemigrations` then `migrate` |
| `TemplateDoesNotExist` | Check folder path — inner `app_name/` folder is missing |
| `404 Not Found` | Check URL path ends with `/` and `include()` is in project `urls.py` |
| `ImportError` in urls.py | Add `from . import views` at the top of `urls.py` |

---

## Presenter's Guide

As the instructor, your role in this session shifts from lecturing to facilitating.

### 1. Structure of the Session
*   **First 15 Minutes:** Quick recap using the terminal commands and MVT checklist above. Q&A for any blockers from the previous assignment.
*   **Next 90 Minutes:** Students work individually or in pairs on the `class_task.md` (Try It Yourself) questions.
*   **Last 15 Minutes:** Review the solutions as a class. Show them on the projector.

### 2. Common Pitfalls to Watch Out For
While walking around the lab, keep an eye out for these common beginner mistakes:
*   **Forgetting to activate the virtual environment:** If students get a `Command 'django-admin' not found` or `ModuleNotFoundError: No module named 'django'` error, they probably forgot to activate their `djenv`.
*   **Running commands in the wrong directory:** `python manage.py runserver` only works if the terminal is currently *inside* the folder containing `manage.py`.
*   **Forgetting to update `INSTALLED_APPS`:** If their app isn't working or templates aren't loading, check `settings.py` first.
*   **URL trailing slashes:** Django URLs conventionally end with a slash (`path('home/', ...)`). If a student forgets the slash, they might get a 404 error.
*   **Import errors:** Forgetting to import the view (`from . import views`) in `urls.py`.

### 3. Reviewing the Solutions
At the end of the class, it is highly recommended to code the final solution live on the projector. Explain your thought process as you type. If you make a typo and get an error, *use it as a teaching moment* to show them how to read the Django error screen.


## Recommended Video Tutorials
Students can search for the following excellent YouTube tutorials on their own to supplement this session:

1. CS50 - CS50 Web Programming - Django
2. JustDjango - Django Beginner Course
3. Corey Schafer - Django Tutorial Part 1
4. Programming with Mosh - Django Tutorial for Beginners
