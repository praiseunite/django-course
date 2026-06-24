# Assignment: Session 2

**Submission Guidelines:** Submit screenshots and code snippets in a Word document or PDF.

### Task 1: Portfolio App (Practical)
Open the `my_portfolio` project you created for homework in Session 1.
1. Create a new app called `projects`.
2. Activate the `projects` app in `settings.py`.
3. Create a View that returns an `HttpResponse` saying "My Recent Projects".
4. Create the necessary `urls.py` files to route traffic so that visiting `http://127.0.0.1:8000/work/` displays your view.
**Proof:** Provide a screenshot of the browser showing the working page.

### Task 2: Understanding MVT Wiring (Theory)
Based on what we learned today, what would happen if:
1. You created a `models.py` file, but forgot to add the app to `INSTALLED_APPS`?
2. You created a view and a template, but forgot to add the URL path to `urls.py`?
*Write a short 1-2 sentence answer for both scenarios.*

### Task 3: Template Creation Challenge (Practical Prep)
Inside your `projects` app, manually create the folder structure needed for templates. Remember the rule: `templates/app_name/file.html`.
Create a file called `project_list.html` and write basic HTML inside it (just a header and a paragraph). You don't need to link it to a view yet, just create the file structure.
**Proof:** Provide a screenshot of your VS Code/Editor showing the folder tree on the left side, proving the nested folders are correctly named.
