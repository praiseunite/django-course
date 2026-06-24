# Assignment: Session 7

**Submission Guidelines:** Submit screenshots and code snippets in a Word document or PDF.

### Task 1: Theory
Explain the difference between a GET request and a POST request in your own words. Why must a login form always use `method="POST"`?

### Task 2: Custom Validation (Practical)
Open your `company_portal` project from the Session 6 Class Task.
1. Create a `forms.py` file in the `hr` app.
2. Create an `EmployeeForm` (ModelForm) connected to your `Employee` model.
3. Write a custom validation method (`clean_first_name`) that ensures the employee's first name does NOT contain the word "Admin". If it does, raise a `forms.ValidationError`.
4. Create a view and template to render this form.
5. Try to submit a form with the first name "Admin" and take a screenshot of the resulting error message shown on the webpage.

**Proof:** Provide the code for your `forms.py` file, and the screenshot of the validation error working on the webpage.
