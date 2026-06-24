# Class Task: Your First Django Project

**Objective:** To practice creating a virtual environment, installing Django, and starting a project. You will execute these commands step-by-step.

### Step 1: Create a Project Folder
1. Open your terminal or command prompt.
2. Create a new directory for your class work and move into it.
```bash
mkdir aptech_django
cd aptech_django
```
*Why? We want a clean space to keep all our course projects organized.*

### Step 2: Create a Virtual Environment
Run the following command to create an isolated environment named `djenv`.
```bash
python -m venv djenv
```
*Why? This creates a safe "box" where we can install Django without interfering with other Python projects on your computer.*

### Step 3: Activate the Environment
You must activate the environment to start using it.
*   **On Windows:**
    ```cmd
    djenv\Scripts\activate
    ```
*   **On Mac/Linux:**
    ```bash
    source djenv/bin/activate
    ```
*Why? Notice the `(djenv)` that appears at the start of your terminal line? This proves you are now inside the virtual box!*

### Step 4: Install Django
Now, install the Django framework.
```bash
pip install django
```
*Why? `pip` reaches out to the internet, downloads the Django package, and installs it safely inside our `djenv` environment.*

### Step 5: Start a Django Project
Let's create the scaffolding for our website. Let's call it `school_project`.
```bash
django-admin startproject school_project
```
*Why? This tells Django's built-in tool to generate all the necessary configuration files and folder structures for a new web project automatically.*

### Step 6: Run the Server
Let's see if it works! First, move inside the newly created project folder, then run the development server.
```bash
cd school_project
python manage.py runserver
```
*Why? `manage.py` is your project's control script. The `runserver` command starts a lightweight, local web server so you can preview your site on your own computer.*

**Final Check:**
Open your web browser and go to `http://127.0.0.1:8000`. You should see the Django welcome page with a rocket taking off! Congratulations on your first Django site!
