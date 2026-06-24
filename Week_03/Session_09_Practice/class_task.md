# Class Task: "Try It Yourself" Challenge

**Objective:** Build a robust "Contact Us" page that accepts user feedback, validates it, and saves it to a database table, using a styled template.

### Task 1: The App and Model
1. In your existing `company_portal` project, create a new app called `contact`.
2. Register the app in `settings.py`.
3. Create a `Feedback` model in `contact/models.py` with three fields:
   * `name` (CharField)
   * `email` (EmailField)
   * `message` (TextField)
4. Run migrations!

### Task 2: The ModelForm
1. Create `contact/forms.py`.
2. Create a `FeedbackForm` that inherits from `forms.ModelForm`.
3. Connect it to the `Feedback` model.
4. **Challenge:** Add a custom widget to the `message` field so it displays as a large text box with the placeholder "Tell us what you think...".

### Task 3: The View
1. Open `contact/views.py`.
2. Write a function-based view called `contact_page(request)`.
3. Implement the `if request.method == 'POST'` logic.
4. If the form is valid, save it, and return a simple `HttpResponse("Thank you for your feedback!")`.
5. If it's a GET request, pass the empty form to the template.

### Task 4: The Template
1. Create the template `contact/templates/contact/contact_form.html`.
2. Write standard HTML. Include an `<h1>` tag.
3. Add the `<form method="POST">`.
4. Include the CSRF token!
5. Render the form using `{{ form.as_p }}`.
6. Add a submit button.

### Task 5: Routing and Testing
1. Wire the URLs so that visiting `http://127.0.0.1:8000/contact/` loads your view.
2. Open the page, fill out the form, and submit it.
3. Check your Admin panel (register the `Feedback` model first!) to ensure your data was saved.
