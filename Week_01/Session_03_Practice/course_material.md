# Session 3: Practice & "Try It Yourself" Lab

Welcome to the first dedicated lab session! This session is designed entirely around hands-on practice. The goal is for students to consolidate what they learned in Book Sessions 1-3 (Our Sessions 1 & 2): Environment setup, starting projects, creating apps, and basic MVT wiring.

---

## Presenter's Guide

As the instructor, your role in this session shifts from lecturing to facilitating. 

### 1. Structure of the Session
*   **First 15 Minutes:** Quick recap of the terminal commands and MVT flow. Q&A for any blockers from the previous assignment.
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
